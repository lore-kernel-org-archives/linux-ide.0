From: Tejun Heo <tj@kernel.org>
Subject: Re: FYI: BUG in SATA Promise 300 TX4 (2.6.24 - 2.6.27-3) w/Linux
Date: Tue, 18 Nov 2008 10:11:58 +0900
Message-ID: <4922165E.9070203@kernel.org>
References: <491C9A4F.1020801@tlinx.org>	<491FB7E2.2030105@kernel.org> <18719.65298.689618.835202@harpo.it.uu.se> <492059B1.4030708@how.dk> <49205AD7.3080009@how.dk> <4920D093.2030508@kernel.org> <492159E0.1050804@how.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:52945 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751076AbYKRBMH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Nov 2008 20:12:07 -0500
In-Reply-To: <492159E0.1050804@how.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Favrholdt <linux-ide@how.dk>
Cc: linux-ide@vger.kernel.org

Peter Favrholdt wrote:
> Hi Tejun,
> 
> Thanks for your reply.
> 
> Tejun Heo wrote:
>> Does unloading and reloading sata_promise fix the problem?
> 
> I had sata_promise linked into the kernel so I had to recompile and
> reboot. The reboot fixed it (didn't turn power off - just reboot).
> 
> I then tried with sata_promise as a module. Four dd's reading the drives
> and shortly same problem:
> 
> [  700.520101] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x1380000
> action 0x6 frozen
> [  700.520112] ata1: SError: { 10B8B Dispar BadCRC TrStaTrns }
> [  700.520120] ata1.00: cmd c8/00:00:90:0e:e6/00:00:00:00:00/e1 tag 0
> dma 131072 in
> [  700.520122]          res 40/00:28:00:00:00/00:00:00:00:00/40 Emask
> 0x4 (timeout)
> [  700.520126] ata1.00: status: { DRDY }
> [  700.520169] ata1: hard resetting link
> [  705.910331] ata1: link is slow to respond, please be patient (ready=-19)
> [  710.531474] ata1: COMRESET failed (errno=-16)
> [  710.531531] ata1: hard resetting link
> [  715.920526] ata1: link is slow to respond, please be patient (ready=-19)
> 
> I tried removing sata_promise the nice way using modprobe:
> 
> # modprobe -r -f sata_promise
> FATAL: Module sata_promise is in use.
> 
> then the not-so-nice way using rmmod -f and inserting it again. It
> doesn't work. Here are the relevant parts from dmesg (removing and
> inserting):

Oh... you first need to wait for the kernel to be done with the devices.
 ie. unmount all filesystems living on those && wait till EH finishes.

-- 
tejun
