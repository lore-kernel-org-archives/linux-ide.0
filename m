From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Frequent Head Unload Problem
Date: Tue, 14 Apr 2009 19:27:16 -0600
Message-ID: <49E537F4.8000807@gmail.com>
References: <49E4BF3E.9040105@gavsworld.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:43335 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755710AbZDOB10 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Apr 2009 21:27:26 -0400
Received: by fxm2 with SMTP id 2so2686070fxm.37
        for <linux-ide@vger.kernel.org>; Tue, 14 Apr 2009 18:27:23 -0700 (PDT)
In-Reply-To: <49E4BF3E.9040105@gavsworld.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gavin Cameron <gavin@gavsworld.net>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

Gavin Cameron wrote:
> Hi,
> 
> It's been a while since I've been in touch. I previously had 2 problems:
> 1. PATA DVD writer not working
> 2. Frequent HDD head unloads
> 
> I eventually caved in and replaced the PATA DVD drive with a SATA and 
> that works perfectly. However, this head unloading in really annoying 
> primarily because the noise the drives makes just doens't sound healthy 
> - it's a high pitch squeal and then a couple of clicks.

Can you tell which drive is doing it? I'm assuming it's not both.. If 
you can figure out which one you can try some different APM values to 
see if that helps anything. You could also try disabling the standby 
timer in case that's doing it, with "hdparm -S 0".

If none of those help, there may not be a lot else you can do about it. 
The OS really has no control over when the drive decides to unload, 
other than those settings..

> 
> Anyway, a reminder of the basic system:
>     * ASUS M2V M/B (VIA K8T890 / VIA VT8237A chipset)
>     * AMD Athlon 64 X2 6000+
>     * SATA LiteOn DVD RAM/RW
>     * Ubuntu 9.04 (Beta) - kernel 2.6.28-11-generic
> 
> Since I last was in touch, I've converted the system to Ubuntu (I was 
> hoping that it was a Fedora quirk) with no change in head unloads with 
> either 8.10 or 9.04.
> 
> I've tried the following in /etc/rc.local :
> /sbin/hdparm -B 254 /dev/sda
> /sbin/hdparm -B 254 /dev/sdb
> 
> Which makes no difference at all. Also, I tried setting 255, but that 
> also had no affect.
> 
> I've included all of the normal files that I think you may need:
> 
> sudo dmidecode > dmidecode.txt
> sudo hdparm -I /dev/sda > hdparm-sda.txt
> sudo hdparm -I /dev/sdb > hdparm-sdb.txt
> sudo smartctl -a /dev/sda > smartctl-sda.txt
> sudo smartctl -a /dev/sdb > smartctl-sdb.txt
> lsmod > lsmod.txt
> 
> Hopefully you can find the root of the problem.
> 
> Best regards,
> Gavin.
> 

