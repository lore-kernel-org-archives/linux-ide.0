From: Tejun Heo <teheo@suse.de>
Subject: Re: Seagate HDD Frequent Head Unload - hdparm/dmidecode/smartctl
 output
Date: Mon, 04 Aug 2008 07:42:36 +0900
Message-ID: <4896345C.4000304@suse.de>
References: <488B27CE.5060106@i-nz.net> <488D751C.5080302@suse.de>	 <488D8B97.1040805@i-nz.net> <488D8ED1.2040400@suse.de>	 <3db1ec7f0808020601h20b2282ch51e6d93a484ac61c@mail.gmail.com>	 <48956B0C.3030406@suse.de> <3db1ec7f0808030829h58ca1adck33485af364d82ced@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55905 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757485AbYHCWnL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Aug 2008 18:43:11 -0400
In-Reply-To: <3db1ec7f0808030829h58ca1adck33485af364d82ced@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Ivan N. Zlatev" <contact@i-nz.net>
Cc: linux-ide@vger.kernel.org

Ivan N. Zlatev wrote:
> On Sun, Aug 3, 2008 at 11:23 AM, Tejun Heo <teheo@suse.de> wrote:
>> Ivan N. Zlatev wrote:
>>> Hi again,
>>>
>>> It appears that the storage-fixup rule [1] doesn't work. Verbose
>>> output below[2]. Also I saw that you use hdparm -i and sg_inq so
>>> output from those for the HDD too. I badly failed to understand this
>>> brainf*** called bash :-), so may be you can advice what's going
>>> wrong? Thanks in advance.
>> Can you please the attached updated script?  The previous version failed
>> match if dmi string contains leading or trailing blanks.
>>
> 
> That works, thanks. It might be a good idea to get storage-fixup
> pushed as a compulsory update for openSUSE 11? Thanks again.

Yeah, I'll see to it.

Thanks.

-- 
tejun
