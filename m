From: "Ivan N. Zlatev" <contact@i-nz.net>
Subject: Re: Seagate HDD Frequent Head Unload - hdparm/dmidecode/smartctl
 output
Date: Mon, 28 Jul 2008 12:04:23 +0300
Message-ID: <488D8B97.1040805@i-nz.net>
References: <488B27CE.5060106@i-nz.net> <488D751C.5080302@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:42417 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449AbYG1JEn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Jul 2008 05:04:43 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2021507fgg.17
        for <linux-ide@vger.kernel.org>; Mon, 28 Jul 2008 02:04:41 -0700 (PDT)
In-Reply-To: <488D751C.5080302@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <teheo@suse.de>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Ivan N. Zlatev wrote:
>> I am having frequent head unloads on a Dell Vostro 1400 laptop with a
>> Seagate HDD. As explained on the Wiki[1] I am attaching for you the
>> output of:
>>
>>    * hdparm -I
>>    * dmidecode
>>    * smartctl --all (in addition)
>>
>> I hope this information is useful for you.
>>
>> I am currently using a workaround to prevent the unloads as described
>> here - http://en.opensuse.org/Disk_Power_Management .
>>
>> [1]
>> http://ata.wiki.kernel.org/index.php/Known_issues#Drives_which_perform_frequent_head_unloads_under_Linux
> 
> Can you please test the attached storage-fixup.conf?  If you're on suse,
> just do "zypper install storage-fixup" and replace
> /etc/storage-fixup.conf with the attached file, remove the manual
> workaround and see whether the problem is gone.
> 

I tested and it seems that the right value for my configuration is 254 
instead of 255. With 255 I still get spin downs.

BTW I noticed that on http://en.opensuse.org/Disk_Power_Management the 
script sets a combination of APM and spin-down time, e.g:

    [1] hdparm -q -B 200 -q -S 252 /dev/sda

With that I also don't get spin downs. So compared to:

    [2] hdparm  -B 254 /dev/sda

will [1] or [2] be better for the HDD in terms of power consumption and 
overheating? Would *not* disabling the APM for the HDD (is what 254/255 
do?), but setting the spin down timeout to something more sensible be 
better for the HDD? I have no idea if spinning down the head is the only 
thing HDDs do for power saving. I suppose you would know best?

Also on another note I accidentally saw two more potential entries for 
your storage-fixup on the linux-ide list (I do not know if you monitor it):

    * http://www.spinics.net/lists/linux-ide/msg24667.html
    * http://www.spinics.net/lists/linux-ide/msg24460.html

Kind Regards,
-- 
Ivan N. Zlatev

Web: http://www.i-nZ.net
"It's all some kind of whacked out conspiracy."

