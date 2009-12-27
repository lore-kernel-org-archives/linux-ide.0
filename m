From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH 0/3] AHCI updates: Marvell AHCI PATA works; pata_marvell
 fate?
Date: Sun, 27 Dec 2009 15:52:19 -0600
Message-ID: <4B37D713.4070407@gmail.com>
References: <20090417023949.GA14469@havoc.gtf.org> <loom.20091227T054252-842@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.211.176]:35220 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbZL0Vsh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Dec 2009 16:48:37 -0500
Received: by ywh6 with SMTP id 6so9995817ywh.4
        for <linux-ide@vger.kernel.org>; Sun, 27 Dec 2009 13:48:36 -0800 (PST)
In-Reply-To: <loom.20091227T054252-842@post.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Raman Gupta <rocketraman@fastmail.fm>
Cc: linux-ide@vger.kernel.org

On 12/26/2009 11:13 PM, Raman Gupta wrote:
> Jeff Garzik<jeff<at>  garzik.org>  writes:
>> This is an update of the recent libahci patchset, currently available
>> on the 'libahci' branch of
>> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
>> [...]
>> The mv-ahci code is obviously still a bit raw with "#if 0" in places,
>> but it is nonetheless ready for testing.
>
> I tested the libata-dev kernel as of commit c3939cc09. I had to comment out a
> bunch of code (for example, code related to the sntf board in ahci.c and some
> other stuff) and add a cap2 variable to the ahci_host_priv struct in ahci.h in
> order to successfully compile the branch.
>
> I also had to comment out the pata_enable check in mv-ahci.c:mv_ahci_init_one in
> order to get the mv_ahci module to initialize my hardware, even though I have
> the pata_marvell module blacklisted.
>
> My test hardware:
>
> Intel D75XBX2 motherboard with 2 onboard SATA controllers
> - ICH7 controller in AHCI mode
>    - 3 disks (2 x ST3320620AS, 1 x ST3500418AS)
> - Marvell 88SE6145 controller, using AHCI (ahci.marvell_enable=1)
>    - 3 disks (3 x ST3500418AS)
>
> I used "fio surface-scan" for my test (is that a good way to test this?) and I
> found no regressions from the stock Fedora 12 kernel 2.6.31.6-166.fc12.x86_64.
> However, I was hoping the latest libata-dev branch resolved this issue:
>
> https://bugzilla.redhat.com/show_bug.cgi?id=549981
>
> It did not. I continue to get the same error as described in my bugzilla report
> with libata-dev.

I wouldn't expect any bug fixes to be in that branch, it's just a code 
reorganization.

 From your last post on the Bugzilla report, it looks like all 3 drives 
basically stopped talking to the point they wouldn't respond to IDENTIFY 
commands. That seems really strange to me. You mentioned you were doing 
a surface scan at the time, which presumably would involve all disks 
being accessed simultaneously. I'd have a good look at the hardware on 
that system, specifically the power supply. We've seen a number of cases 
where running multiple HDs on a system can trigger such problems with 
SATA links because of voltage sags (even momentary). HDs draw much 
higher peak power under certain conditions than when idle so such 
problems may not be obvious unless you stress multiple drives at once.

I'm not sure if that's related to the SMART issue you were seeing or not..
