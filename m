From: "Ivan N. Zlatev" <contact@i-nz.net>
Subject: Re: Seagate HDD Frequent Head Unload - hdparm/dmidecode/smartctl output
Date: Sun, 3 Aug 2008 18:29:34 +0300
Message-ID: <3db1ec7f0808030829h58ca1adck33485af364d82ced@mail.gmail.com>
References: <488B27CE.5060106@i-nz.net> <488D751C.5080302@suse.de>
	 <488D8B97.1040805@i-nz.net> <488D8ED1.2040400@suse.de>
	 <3db1ec7f0808020601h20b2282ch51e6d93a484ac61c@mail.gmail.com>
	 <48956B0C.3030406@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.251]:47551 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755585AbYHCP3g (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Aug 2008 11:29:36 -0400
Received: by an-out-0708.google.com with SMTP id d40so263636and.103
        for <linux-ide@vger.kernel.org>; Sun, 03 Aug 2008 08:29:34 -0700 (PDT)
In-Reply-To: <48956B0C.3030406@suse.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <teheo@suse.de>
Cc: linux-ide@vger.kernel.org

On Sun, Aug 3, 2008 at 11:23 AM, Tejun Heo <teheo@suse.de> wrote:
> Ivan N. Zlatev wrote:
>> Hi again,
>>
>> It appears that the storage-fixup rule [1] doesn't work. Verbose
>> output below[2]. Also I saw that you use hdparm -i and sg_inq so
>> output from those for the HDD too. I badly failed to understand this
>> brainf*** called bash :-), so may be you can advice what's going
>> wrong? Thanks in advance.
>
> Can you please the attached updated script?  The previous version failed
> match if dmi string contains leading or trailing blanks.
>

That works, thanks. It might be a good idea to get storage-fixup
pushed as a compulsory update for openSUSE 11? Thanks again.
