# https://github.com/brennovich/cheat-ruby-sheets/blob/master/factory_bot.md

FactoryBot.define do
  factory :message do
    before(:build) do |message, eval|
        user = create(:user)
        create(:profile, user: user)
    end

    to {"bounceumbrellaumbrella@m.staging.fcctrl.com"}
    from {"Jake Cowton <jake@faircustodian.com>"}
    subject {"test"}
    read_status {false} 
    raw_payload {
      {"headers"=>'Received: by mx0057p1mdw1.sendgrid.net with SMTP id 4eoJsRq3Ju Thu, 24 Jan 2019 14:03:05 +0000 (UTC) Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45]) by mx0057p1mdw1.sendgrid.net (Postfix) with ESMTPS id 561F63C10E0 for <bounceumbrellaumbrella@m.staging.fcctrl.com>; Thu, 24 Jan 2019 14:03:05 +0000 (UTC) Received: by mail-wm1-f45.google.com with SMTP id f188so3131826wmf.5 for <bounceumbrellaumbrella@m.staging.fcctrl.com>; Thu, 24 Jan 2019 06:03:05 -0800 (PST) DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=faircustodian.com; s=google; h=to:from:subject:organization:message-id:date:user-agent :mime-version:content-language; bh=Wgx9zzG79DCqEe7Y+iLRaInzo4whMVb3Bk73e6Puze8=; b=X4w6eXpJeP0Xc3LeVu1fn3eFcXTJd20intQHkeA2lUdl71lreoxufsLK9g+6gmUZK0 PQeSCabU4kAJFC+THYRiOwP5Q5hN7by9UValJomxOW/Q0mSs6Dqdwpd9n3rH0fCTc8KW PTTNiC8W6MHcL8g8dClTQgOZqQ7ijjF1kC25ms24zuMFf3q+bJH2nD0OW9pauFf//ChY WcKKA9rR1586/VTk8aFwpon1uQ3QGxJ8JuR3zKcJuC6giDozTLMsFkZhzXy0e+A1rKCE gFiLydnUNMQPm0FsOXYZAMosEcXT18lG/PIzL02Bszq+d86zuJK7rnUfsgV7dbl32fRO zxqQ== X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1e100.net; s=20161025; h=x-gm-message-state:to:from:subject:organization:message-id:date :user-agent:mime-version:content-language; bh=Wgx9zzG79DCqEe7Y+iLRaInzo4whMVb3Bk73e6Puze8=; b=l6VHMCNF4a/Xa+5UpAnx9/U9FDOjfeyj9sYIgsPtGMWkVT3E8mWIkWd/M6kLOUlErZ 0ZPDcjG0Z8JN5I9yMLu1Pi4F4WVmVrCvkM1bq14HHBgbkuz2Euzu+4QCqC46E7sU+iHG bhiNk+kETh2hA91OlrMoKLQGx0sb4io8zWkD4O74XxqnBJzjdQ8hY/w5n+J8cCLEf+1c 4MMKdzU/yXiyIcQsRO7v1ZEw4mq+VlXprRQ/rMu2cEtP3FHH5NVN+hkFL5eFx4/I8sQT eKWeWJbPThIp5ibnltDWESO+vomDmAVmxEAl+aQi3cqLCa5rWkD7XuScOK0cSzksUJdE SBqA== X-Gm-Message-State: AJcUukcKh10mjaxrhz0fXqQ8D0UothkuJ1xdgufcnQlX2BKRB+yb2ylK s/cVy2xLFbJ7wWGxwaYV9ZDqdqRPJDc= X-Google-Smtp-Source: ALg8bN7kTbDQlTr0YJiuz51aCAaVlgpsskmaFKy3W9dYKzL3QqSz6dlJ+1sZ1P6lbDHL/ELesvQBIQ== X-Received: by 2002:a1c:7d54:: with SMTP id y81mr2819569wmc.106.1548338583219; Thu, 24 Jan 2019 06:03:03 -0800 (PST) Received: from [10.150.12.37] ([185.59.183.230]) by smtp.gmail.com with ESMTPSA id f22sm12149900wmj.26.2019.01.24.06.03.02 for <bounceumbrellaumbrella@m.staging.fcctrl.com> (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128); Thu, 24 Jan 2019 06:03:02 -0800 (PST) To: bounceumbrellaumbrella@m.staging.fcctrl.com From: Jake Cowton <jake@faircustodian.com> Subject: test Organization: Fair Custodian Message-ID: <21fa6e19-a3df-fe80-5505-8971bf40ee7d@faircustodian.com> Date: Thu, 24 Jan 2019 14:03:01 +0000 User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.2.1 MIME-Version: 1.0 Content-Type: multipart/alternative; boundary="------------AFCB6B64827E07262E5896D7"Content-Language: en-GB', 
            "dkim"=>"{@faircustodian.com : pass}", 
            "to"=>"bounceumbrellaumbrella@m.staging.fcctrl.com", 
            "from"=>"Jake Cowton <jake@faircustodian.com>", 
            "html"=>"<html><head><meta http-equiv='content-type' content='text/html; charset=UTF-8'></head><body text=\"#000000\" bgcolor=\"#FFFFFF\"><p><font face=\"Helvetica, Arial, sans-serif\">test</font></p><p><font face=\"Helvetica, Arial, sans-serif\">test</font><br></p><p><font face=\"Helvetica, Arial, sans-serif\">test</font></p><p><font face=\"Helvetica, Arial, sans-serif\">test</font></p><p><font face=\"Helvetica, Arial, sans-serif\">test</font></p><p><font face=\"Helvetica, Arial, sans-serif\">test</font></p><p><font face=\"Helvetica, Arial, sans-serif\">test</font></p><p><font face=\"Helvetica, Arial, sans-serif\">test</font></p><p><font face=\"Helvetica, Arial, sans-serif\">test</font></p><p><font face=\"Helvetica, Arial, sans-serif\">test</font></p><p><font face=\"Helvetica, Arial, sans-serif\">test</font></p><p><font face=\"Helvetica, Arial, sans-serif\">test</font></p><p><font face=\"Helvetica, Arial, sans-serif\">test</font></p><p><font face=\"Helvetica, Arial, sans-serif\">test</font></p><p><font face=\"Helvetica, Arial, sans-serif\">test</font></p><p><font face=\"Helvetica, Arial, sans-serif\">test</font></p><p><font face=\"Helvetica, Arial, sans-serif\">test</font></p><p><font face=\"Helvetica, Arial, sans-serif\">test</font></p><p><font face=\"Helvetica, Arial, sans-serif\">test</font></p><p><font face=\"Helvetica, Arial, sans-serif\">test</font></p><p><font face=\"Helvetica, Arial, sans-serif\">test</font></p><p><font face=\"Helvetica, Arial, sans-serif\">test</font></p><div class=\"moz-signature\">-- <br>      Fair Custodian<br>      Jake Cowton<br>      Co-Founder<br>      <a href=\"https://beta.faircustodian.com\">https://beta.faircustodian.com</a><br></div></body></html>", "text"=>"testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest-- Fair CustodianJake CowtonCo-Founderhttps://beta.faircustodian.com",
            "sender_ip"=>"209.85.128.45", 
            "envelope"=> "{\"to\":[\"bounceumbrellaumbrella@m.staging.fcctrl.com\"],\"from\":\"jake@faircustodian.com\"}", 
            "subject"=>"test", 
            "charsets"=>"{\"to\":\"UTF-8\",\"html\":\"utf-8\",\"subject\":\"UTF-8\",\"from\":\"UTF-8\",\"text\":\"utf-8\"}\", \"attachments\"=>\"0\"}", }.to_json
    }
    open_count {0}

    factory :message_with_sender_two do
      from { "Ben Fielding <ben@faircustodian.com>" }
    end

    factory :message_with_sender_three do
      from { "Saul Gowens <saul@faircustodian.com>" }
    end

    factory :message_with_sender_four do
      from { "Jay Snee <jay@faircustodian.com>" }
    end
  end
end