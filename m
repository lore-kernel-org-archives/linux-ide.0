From: "Christian Pernegger" <pernegger@gmail.com>
Subject: Re: Western Digital GreenPower drives and Linux
Date: Thu, 10 Apr 2008 17:01:38 +0200
Message-ID: <bb145bd20804100801y157b4a34m82f084d27f1e0586@mail.gmail.com>
References: <200804092118.35501.tvrtko@ursulin.net>
	 <200804100848.08442.tvrtko@ursulin.net>
	 <1207831481.1514.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.177]:64391 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759325AbYDJPBk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Apr 2008 11:01:40 -0400
Received: by el-out-1112.google.com with SMTP id v27so29152ele.17
        for <linux-ide@vger.kernel.org>; Thu, 10 Apr 2008 08:01:39 -0700 (PDT)
In-Reply-To: <1207831481.1514.8.camel@localhost>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Tvrtko A. Ursulin" <tvrtko@ursulin.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

[ Keep me CCd on this, please. ]

>  Those fancy new WD GreenPower drives seem to be heavily suffering from the
>  rapidly increasing head load/unload problem. [...] I got one of them
>  (WD5000AACS) recently and to my horror [...]

I have the same disks, only with more warranty and supposedly
"enterprise" firmware (WD1000FYPS). The bug is the same, though, on
all four of them (~ 9 cycles /hour):

  9 Power_On_Hours          0x0032   099   099   000    Old_age
Always       -       917
193 Load_Cycle_Count        0x0032   198   198   000    Old_age
Always       -       8025

  9 Power_On_Hours          0x0032   099   099   000    Old_age
Always       -       906
193 Load_Cycle_Count        0x0032   198   198   000    Old_age
Always       -       7908

  9 Power_On_Hours          0x0032   099   099   000    Old_age
Always       -       907
193 Load_Cycle_Count        0x0032   198   198   000    Old_age
Always       -       8051

  9 Power_On_Hours          0x0032   099   099   000    Old_age
Always       -       918
193 Load_Cycle_Count        0x0032   198   198   000    Old_age
Always       -       7869

>  I got the _DOS_ utility from WD which issues vendor specific commands to
>  control that feature.

Have they confirmed it's a bug? I have no idea how often the disks
should do that.

>  [...] With it the unload feature can be either disabled or timer set from
>  100ms to 25.5 seconds. But obviously I can't try it...

Why? Using a DOS boot disk once would not be that bad as a workaround,
would it? Or is the setting not persistent? Either way I'd prefer to
be able to leave the feature on (in usable form), eventually.

The bigger question is - why the rapid loads / unloads? In my case the
disks are idle hours at a time. No system files on there, just bulk
data. Does / could the controller (sata_sil24 in my case) have any
influence on this kind of power management?

Thanks,

C.
