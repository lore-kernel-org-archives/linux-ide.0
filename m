From: Peter Favrholdt <linux-ide@how.dk>
Subject: Re: [PATCH #upstream-fixes] sata_promise: request follow-up SRST
Date: Tue, 25 Nov 2008 14:00:43 +0100
Message-ID: <492BF6FB.1050004@how.dk>
References: <491C9A4F.1020801@tlinx.org>	<491FB7E2.2030105@kernel.org>	<18719.65298.689618.835202@harpo.it.uu.se>	<492059B1.4030708@how.dk>	<49205AD7.3080009@how.dk>	<4920D093.2030508@kernel.org>	<492159E0.1050804@how.dk>	<4922165E.9070203@kernel.org>	<49230361.2010001@how.dk>	<492371F4.7020400@kernel.org>	<49253A6D.1040202@how.dk> <18725.17831.755158.999770@harpo.it.uu.se> <49263F80.2060607@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pfepb.post.tele.dk ([195.41.46.236]:47958 "EHLO
	pfepb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837AbYKYNAr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Nov 2008 08:00:47 -0500
In-Reply-To: <49263F80.2060607@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Mikael Pettersson <mikpe@it.uu.se>, Jeff Garzik <jeff@garzik.org>

Hi Tejun,

After running dd several times finally my setup failed. Unfortunately it 
didn't recover :-(

Tejun Heo wrote:
 > sata_promise hardreset doesn't seem to be able to acquire the initial
 > D2H Reg FIS after hardreset leading to hardreset timeouts.  Request
 > follow-up SRST.
 >
 >  http://article.gmane.org/gmane.linux.ide/36186
 >
 > Signed-off-by: Tejun Heo <tj@kernel.org>
 > ---
 > Peter, can you please test this one too?  It's essentially the same
 > code just slightly prettier.  Mikael, what do you think about this?

/usr/src/linux-2.6.27.7# patch -p1
<../sata_promise_tejun_heo_2008-11-21.patch
patching file drivers/ata/sata_promise.c
Hunk #1 succeeded at 708 (offset -2 lines).

Here is dmesg:

[133424.882458] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x1380000 
action 0x6 frozen
[133424.882468] ata1: SError: { 10B8B Dispar BadCRC TrStaTrns }
[133424.882477] ata1.00: cmd c8/00:00:a0:2c:e6/00:00:00:00:00/e1 tag 0 
dma 131072 in
[133424.882478]          res 40/00:28:00:00:00/00:00:00:00:00/40 Emask 
0x4 (timeout)
[133424.882482] ata1.00: status: { DRDY }
[133424.882522] ata1: hard resetting link
[133430.430034] ata1: link is slow to respond, please be patient (ready=-19)
[133434.930042] ata1: SRST failed (errno=-16)
[133434.930137] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[133439.950170] ata1.00: qc timeout (cmd 0xec)
[133439.950424] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x5)
[133439.950428] ata1.00: revalidation failed (errno=-5)
[133439.950480] ata1: hard resetting link
[133440.460206] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[133440.614296] ata1.00: configured for UDMA/133
[133440.614557] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x9 t4
[133440.614560] ata1: hotplug_status 0x80
[133440.764137] ata1.00: configured for UDMA/133
[133440.764152] ata1: EH complete
[133440.825887] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors 
(500108 MB)
[133440.830103] sd 0:0:0:0: [sda] Write Protect is off
[133440.830113] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[133440.838448] sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[133470.830077] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x1380000 
action 0x6 frozen
[133470.830087] ata1: SError: { 10B8B Dispar BadCRC TrStaTrns }
[133470.830096] ata1.00: cmd c8/00:00:a0:31:e6/00:00:00:00:00/e1 tag 0 
dma 131072 in
[133470.830098]          res 40/00:28:00:00:00/00:00:00:00:00/40 Emask 
0x4 (timeout)
[133470.830101] ata1.00: status: { DRDY }
[133470.830131] ata1: hard resetting link
[133476.380130] ata1: link is slow to respond, please be patient (ready=-19)
[133480.881592] ata1: SRST failed (errno=-16)
[133480.881690] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[133485.882726] ata1.00: qc timeout (cmd 0xec)
[133485.882980] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x5)
[133485.882985] ata1.00: revalidation failed (errno=-5)
[133485.883019] ata1: hard resetting link
[133491.430035] ata1: link is slow to respond, please be patient (ready=-19)
[133495.930034] ata1: SRST failed (errno=-16)
[133495.930137] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[133505.951635] ata1.00: qc timeout (cmd 0xec)
[133505.951875] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x5)
[133505.951879] ata1.00: revalidation failed (errno=-5)
[133505.951930] ata1: hard resetting link
[133511.500191] ata1: link is slow to respond, please be patient (ready=-19)
[133516.010031] ata1: SRST failed (errno=-16)
[133516.010147] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[133546.030141] ata1.00: qc timeout (cmd 0xec)
[133546.030373] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x5)
[133546.030377] ata1.00: revalidation failed (errno=-5)
[133546.030380] ata1.00: disabled
[133546.030406] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe 
frozen t4
[133546.030409] ata1: hotplug_status 0x80
[133546.030456] ata1: hard resetting link
[133551.980075] ata1: link is slow to respond, please be patient (ready=-19)
[133556.060075] ata1: SRST failed (errno=-16)
[133556.060184] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[133556.060231] ata1: link online but device misclassified, retrying
[133556.060265] ata1: hard resetting link
[133562.010032] ata1: link is slow to respond, please be patient (ready=-19)
[133566.100094] ata1: SRST failed (errno=-16)
[133566.100195] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[133566.100242] ata1: link online but device misclassified, retrying
[133566.100285] ata1: hard resetting link
[133572.050066] ata1: link is slow to respond, please be patient (ready=-19)
[133601.160039] ata1: SRST failed (errno=-16)
[133601.160150] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[133601.160190] ata1: link online but device misclassified, retrying
[133601.160198] ata1: limiting SATA link speed to 1.5 Gbps
[133601.160247] ata1: hard resetting link
[133606.220108] ata1: SRST failed (errno=-16)
[133606.220209] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[133606.220250] ata1: link online but device misclassified, device 
detection might fail
[133606.220520] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x9 t3
[133606.220523] ata1: hotplug_status 0x80
[133606.220559] ata1: hard resetting link
[133612.170073] ata1: link is slow to respond, please be patient (ready=-19)
[133616.250074] ata1: SRST failed (errno=-16)
[133616.250176] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[133616.250218] ata1: link online but device misclassified, retrying
[133616.250259] ata1: hard resetting link
[133622.200033] ata1: link is slow to respond, please be patient (ready=-19)
[133626.280039] ata1: SRST failed (errno=-16)
[133626.280117] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[133626.280151] ata1: link online but device misclassified, retrying
[133626.280297] ata1: hard resetting link
[133632.230039] ata1: link is slow to respond, please be patient (ready=-19)
[133661.340061] ata1: SRST failed (errno=-16)
[133661.340127] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[133661.340174] ata1: link online but device misclassified, retrying
[133661.340181] ata1: limiting SATA link speed to 1.5 Gbps
[133661.340216] ata1: hard resetting link
[133666.400844] ata1: SRST failed (errno=-16)
[133666.400939] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[133666.400980] ata1: link online but device misclassified, device 
detection might fail
[133666.401240] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x9 t2
[133666.401243] ata1: hotplug_status 0x80
[133666.401301] ata1: hard resetting link
[133672.360283] ata1: link is slow to respond, please be patient (ready=-19)
[133676.440038] ata1: SRST failed (errno=-16)
[133676.440126] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[133676.440159] ata1: link online but device misclassified, retrying
[133676.440206] ata1: hard resetting link
[133682.390310] ata1: link is slow to respond, please be patient (ready=-19)
[133686.470083] ata1: SRST failed (errno=-16)
[133686.470198] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[133686.470239] ata1: link online but device misclassified, retrying
[133686.470273] ata1: hard resetting link
[133692.430263] ata1: link is slow to respond, please be patient (ready=-19)
[133721.530036] ata1: SRST failed (errno=-16)
[133721.530138] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[133721.530187] ata1: link online but device misclassified, retrying
[133721.530194] ata1: limiting SATA link speed to 1.5 Gbps
[133721.530235] ata1: hard resetting link
[133726.580952] ata1: SRST failed (errno=-16)
[133726.581062] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[133726.581095] ata1: link online but device misclassified, device 
detection might fail
[133726.581358] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x9 t1
[133726.581361] ata1: hotplug_status 0x80
[133726.581412] ata1: hard resetting link
[133732.531480] ata1: link is slow to respond, please be patient (ready=-19)
[133736.610030] ata1: SRST failed (errno=-16)
[133736.610126] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[133736.610173] ata1: link online but device misclassified, retrying
[133736.610207] ata1: hard resetting link
[133742.560043] ata1: link is slow to respond, please be patient (ready=-19)
[133746.640042] ata1: SRST failed (errno=-16)
[133746.640120] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[133746.640252] ata1: link online but device misclassified, retrying
[133746.640272] ata1: hard resetting link
[133752.600033] ata1: link is slow to respond, please be patient (ready=-19)
[133781.650358] ata1: SRST failed (errno=-16)
[133781.650380] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[133781.650389] ata1: link online but device misclassified, retrying
[133781.650394] ata1: limiting SATA link speed to 1.5 Gbps
[133781.650402] ata1: hard resetting link
[133786.700144] ata1: SRST failed (errno=-16)
[133786.700247] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[133786.700279] ata1: link online but device misclassified, device 
detection might fail
[133786.700288] ata1: EH pending after 5 tries, giving up
[133786.700303] sd 0:0:0:0: [sda] Result: hostbyte=0x00 driverbyte=0x08
[133786.700307] sd 0:0:0:0: [sda] Sense Key : 0xb [current] [descriptor]
[133786.700312] Descriptor sense data with sense descriptors (in hex):
[133786.700314]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
[133786.700321]         00 00 00 00
[133786.700324] sd 0:0:0:0: [sda] ASC=0x0 ASCQ=0x0
[133786.700327] end_request: I/O error, dev sda, sector 31863200
[133786.700332] Buffer I/O error on device sda, logical block 3982900
[133786.700337] Buffer I/O error on device sda, logical block 3982901
[133786.700341] Buffer I/O error on device sda, logical block 3982902
[133786.700344] Buffer I/O error on device sda, logical block 3982903
[133786.700347] Buffer I/O error on device sda, logical block 3982904
[133786.700350] Buffer I/O error on device sda, logical block 3982905
[133786.700353] Buffer I/O error on device sda, logical block 3982906
[133786.700356] Buffer I/O error on device sda, logical block 3982907
[133786.700360] Buffer I/O error on device sda, logical block 3982908
[133786.700363] Buffer I/O error on device sda, logical block 3982909
[133786.700384] sd 0:0:0:0: rejecting I/O to offline device
[133786.700390] sd 0:0:0:0: rejecting I/O to offline device
[133786.700422] ata1: EH complete
[133786.700444] sd 0:0:0:0: rejecting I/O to offline device
[133786.700451] sd 0:0:0:0: rejecting I/O to offline device
[133786.700457] sd 0:0:0:0: rejecting I/O to offline device
[133786.700460] sd 0:0:0:0: [sda] READ CAPACITY failed
[133786.700463] sd 0:0:0:0: [sda] Result: hostbyte=0x01 driverbyte=0x00
[133786.700466] sd 0:0:0:0: [sda] Sense not available.
[133786.700471] sd 0:0:0:0: rejecting I/O to offline device
[133786.700476] sd 0:0:0:0: [sda] Write Protect is off
[133786.700478] sd 0:0:0:0: [sda] Mode Sense: 00 00 00 00
[133786.700483] sd 0:0:0:0: rejecting I/O to offline device
[133786.700487] sd 0:0:0:0: [sda] Asking for cache data failed
[133786.700489] sd 0:0:0:0: [sda] Assuming drive cache: write through
[133786.700496] ata1.00: detaching (SCSI 0:0:0:0)
[133786.701352] sd 0:0:0:0: [sda] Stopping disk
[133786.702316] sd 0:0:0:0: [sda] START_STOP FAILED
[133786.702320] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00

> Jeff, please commit only after Peter's verification and Mikael's ACK.
> 
> Thanks.
> 
>  drivers/ata/sata_promise.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
> index ba9a257..917038a 100644
> --- a/drivers/ata/sata_promise.c
> +++ b/drivers/ata/sata_promise.c
> @@ -710,7 +710,12 @@ static int pdc_sata_hardreset(struct ata_link *link, unsigned int *class,
>  			      unsigned long deadline)
>  {
>  	pdc_reset_port(link->ap);
> -	return sata_sff_hardreset(link, class, deadline);
> +
> +	/* sata_promise can't reliably acquire the first D2H Reg FIS
> +	 * after hardreset.  Do non-waiting hardreset and request
> +	 * follow-up SRST.
> +	 */
> +	return sata_std_hardreset(link, class, deadline);
>  }
>  
>  static void pdc_error_handler(struct ata_port *ap)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

