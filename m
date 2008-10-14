From: Scott Beardsley <scott@cse.ucdavis.edu>
Subject: Re: SATA resets via SMART selftest
Date: Mon, 13 Oct 2008 17:19:00 -0700
Message-ID: <48F3E574.9030503@cse.ucdavis.edu>
References: <48EFBD37.8040604@cse.ucdavis.edu> <20081010220820.4ad97574@lxorguk.ukuu.org.uk> <48F382E6.6060305@cse.ucdavis.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.cse.ucdavis.edu ([128.120.246.11]:55089 "EHLO
	mail.cse.ucdavis.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932149AbYJNATL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Oct 2008 20:19:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.cse.ucdavis.edu (Postfix) with ESMTP id 38AFB90006
	for <linux-ide@vger.kernel.org>; Mon, 13 Oct 2008 17:19:10 -0700 (PDT)
Received: from mail.cse.ucdavis.edu ([127.0.0.1])
	by localhost (mail.cse.ucdavis.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 31856-02 for <linux-ide@vger.kernel.org>;
	Mon, 13 Oct 2008 17:19:00 -0700 (PDT)
Received: from [128.120.246.129] (automatic.cse.ucdavis.edu [128.120.246.129])
	by mail.cse.ucdavis.edu (Postfix) with ESMTP id 2B75790002
	for <linux-ide@vger.kernel.org>; Mon, 13 Oct 2008 17:19:00 -0700 (PDT)
In-Reply-To: <48F382E6.6060305@cse.ucdavis.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Scott Beardsley wrote:
> Alan Cox wrote:
>> The timeout set on the command expired so the kernel aborted the command
>> and recovered the link.
> 
> For some strange reason I can't get scsi_logging to work correctly 
> (likely my fault).

Yep, I was looking in the wrong place (and probably at old docs). I had 
to run:

# echo 7 > /proc/sys/dev/scsi/logging_level

Below is that same sequence (SMART short test, then INQUIRYs with 7.5sec 
timeouts this time). The SMART cmd was issued at 1083, the first INQUIRY 
(of a series of 10) is at 1084, the disk finishes resetting at 1168.

Perhaps this is a problem with Seagate's implementation of SMART on this 
disk? hdparm -I states that it does, in fact, support self-tests. The 
timeouts don't seem unusually short (10+sec). I'm stumped why it would 
be timing out.

Scott
---------------------

[ 1064.969694] scsi_add_timer: scmd: ffff88021d4f9800, time: 60000, 
(ffffffffa006f521)
[ 1064.970262] scsi_delete_timer: scmd: ffff88021d4f9800, rtn: 1
[ 1064.970270] scsi_add_timer: scmd: ffff88021d4f91c0, time: 60000, 
(ffffffffa006f521)
[ 1064.970769] scsi_delete_timer: scmd: ffff88021d4f91c0, rtn: 1
[ 1083.788393] scsi_add_timer: scmd: ffff88021d4f91c0, time: 60000, 
(ffffffffa006f521)
[ 1083.797591] scsi_delete_timer: scmd: ffff88021d4f91c0, rtn: 1
[ 1083.797641] scsi_add_timer: scmd: ffff88021d91be80, time: 60000, 
(ffffffffa006f521)
[ 1083.808215] scsi_delete_timer: scmd: ffff88021d91be80, rtn: 1
[ 1083.808358] scsi_add_timer: scmd: ffff88021d91bd40, time: 60000, 
(ffffffffa006f521)
[ 1083.808936] scsi_delete_timer: scmd: ffff88021d91bd40, rtn: 1
[ 1083.808966] scsi_add_timer: scmd: ffff88021d91bc00, time: 60000, 
(ffffffffa006f521)
[ 1083.811553] scsi_delete_timer: scmd: ffff88021d91bc00, rtn: 1
[ 1083.812533] scsi_add_timer: scmd: ffff88021d91bac0, time: 60000, 
(ffffffffa006f521)
[ 1083.812668] scsi_delete_timer: scmd: ffff88021d91bac0, rtn: 1
[ 1083.812678] scsi_add_timer: scmd: ffff88021d91b980, time: 60000, 
(ffffffffa006f521)
[ 1083.812981] scsi_delete_timer: scmd: ffff88021d91b980, rtn: 1
[ 1083.812992] scsi_add_timer: scmd: ffff88021d91bac0, time: 60000, 
(ffffffffa006f521)
[ 1083.813789] scsi_delete_timer: scmd: ffff88021d91bac0, rtn: 1
[ 1083.813921] scsi_block_when_processing_errors: rtn: 1
[ 1083.813940] scsi_add_timer: scmd: ffff88021d91b840, time: 60000, 
(ffffffffa006f521)
[ 1083.814089] scsi_delete_timer: scmd: ffff88021d91b840, rtn: 1
[ 1083.814126] scsi_block_when_processing_errors: rtn: 1
[ 1083.814132] scsi_block_when_processing_errors: rtn: 1
[ 1083.814136] scsi_block_when_processing_errors: rtn: 1
[ 1083.814142] scsi_block_when_processing_errors: rtn: 1
[ 1083.814156] scsi_add_timer: scmd: ffff88021d91b700, time: 10000, 
(ffffffffa006f521)
[ 1083.816710] scsi_delete_timer: scmd: ffff88021d91b700, rtn: 1
[ 1083.822368] scsi_block_when_processing_errors: rtn: 1
[ 1083.822372] scsi_block_when_processing_errors: rtn: 1
[ 1083.822380] scsi_add_timer: scmd: ffff88021d91b5c0, time: 10000, 
(ffffffffa006f521)
[ 1083.878472] scsi_delete_timer: scmd: ffff88021d91b5c0, rtn: 1
[ 1083.878496] scsi_block_when_processing_errors: rtn: 1
[ 1083.878500] scsi_block_when_processing_errors: rtn: 1
[ 1083.878506] scsi_add_timer: scmd: ffff88021d91b480, time: 10000, 
(ffffffffa006f521)
[ 1083.920116] scsi_delete_timer: scmd: ffff88021d91b480, rtn: 1
[ 1083.920139] scsi_block_when_processing_errors: rtn: 1
[ 1083.920143] scsi_block_when_processing_errors: rtn: 1
[ 1083.920150] scsi_add_timer: scmd: ffff88021d91b340, time: 10000, 
(ffffffffa006f521)
[ 1084.012873] scsi_delete_timer: scmd: ffff88021d91b340, rtn: 1
[ 1084.012995] scsi_block_when_processing_errors: rtn: 1
[ 1084.012999] scsi_block_when_processing_errors: rtn: 1
[ 1084.013006] scsi_add_timer: scmd: ffff88021d91b200, time: 10000, 
(ffffffffa006f521)
[ 1084.020169] scsi_delete_timer: scmd: ffff88021d91b200, rtn: 1
[ 1084.020207] scsi_block_when_processing_errors: rtn: 1
[ 1084.020211] scsi_block_when_processing_errors: rtn: 1
[ 1084.020216] scsi_add_timer: scmd: ffff88021d91b0c0, time: 10000, 
(ffffffffa006f521)
[ 1084.021323] scsi_delete_timer: scmd: ffff88021d91b0c0, rtn: 1
[ 1084.023222] scsi_block_when_processing_errors: rtn: 1
[ 1084.023318] scsi_block_when_processing_errors: rtn: 1
[ 1084.023322] scsi_block_when_processing_errors: rtn: 1
[ 1084.023731] scsi_block_when_processing_errors: rtn: 1
[ 1084.023735] scsi_block_when_processing_errors: rtn: 1
[ 1084.023754] scsi_add_timer: scmd: ffff88021d474e40, time: 7500, 
(ffffffffa006f521)
[ 1084.023765] scsi_delete_timer: scmd: ffff88021d474e40, rtn: 1
[ 1084.788506] scsi_block_when_processing_errors: rtn: 1
[ 1084.788568] scsi_block_when_processing_errors: rtn: 1
[ 1084.788571] scsi_block_when_processing_errors: rtn: 1
[ 1084.788856] scsi_block_when_processing_errors: rtn: 1
[ 1084.788859] scsi_block_when_processing_errors: rtn: 1
[ 1084.788872] scsi_add_timer: scmd: ffff88021bd48e80, time: 7500, 
(ffffffffa006f521)
[ 1084.788877] scsi_delete_timer: scmd: ffff88021bd48e80, rtn: 1
[ 1085.716417] scsi_block_when_processing_errors: rtn: 1
[ 1085.716488] scsi_block_when_processing_errors: rtn: 1
[ 1085.716490] scsi_block_when_processing_errors: rtn: 1
[ 1085.716790] scsi_block_when_processing_errors: rtn: 1
[ 1085.716793] scsi_block_when_processing_errors: rtn: 1
[ 1085.716809] scsi_add_timer: scmd: ffff88021d91b980, time: 7500, 
(ffffffffa006f521)
[ 1085.716816] scsi_delete_timer: scmd: ffff88021d91b980, rtn: 1
[ 1086.596181] scsi_block_when_processing_errors: rtn: 1
[ 1086.596277] scsi_block_when_processing_errors: rtn: 1
[ 1086.596279] scsi_block_when_processing_errors: rtn: 1
[ 1086.596631] scsi_block_when_processing_errors: rtn: 1
[ 1086.596634] scsi_block_when_processing_errors: rtn: 1
[ 1086.596697] scsi_add_timer: scmd: ffff88021d91b0c0, time: 7500, 
(ffffffffa006f521)
[ 1086.596703] scsi_delete_timer: scmd: ffff88021d91b0c0, rtn: 1
[ 1087.428274] scsi_block_when_processing_errors: rtn: 1
[ 1087.428369] scsi_block_when_processing_errors: rtn: 1
[ 1087.428372] scsi_block_when_processing_errors: rtn: 1
[ 1087.428724] scsi_block_when_processing_errors: rtn: 1
[ 1087.428727] scsi_block_when_processing_errors: rtn: 1
[ 1087.428788] scsi_add_timer: scmd: ffff88021d91b0c0, time: 7500, 
(ffffffffa006f521)
[ 1087.428794] scsi_delete_timer: scmd: ffff88021d91b0c0, rtn: 1
[ 1088.100442] scsi_block_when_processing_errors: rtn: 1
[ 1088.100509] scsi_block_when_processing_errors: rtn: 1
[ 1088.100512] scsi_block_when_processing_errors: rtn: 1
[ 1088.100801] scsi_block_when_processing_errors: rtn: 1
[ 1088.100804] scsi_block_when_processing_errors: rtn: 1
[ 1088.100820] scsi_add_timer: scmd: ffff88021bd48e80, time: 7500, 
(ffffffffa006f521)
[ 1088.100826] scsi_delete_timer: scmd: ffff88021bd48e80, rtn: 1
[ 1088.580211] scsi_block_when_processing_errors: rtn: 1
[ 1088.580304] scsi_block_when_processing_errors: rtn: 1
[ 1088.580308] scsi_block_when_processing_errors: rtn: 1
[ 1088.580710] scsi_block_when_processing_errors: rtn: 1
[ 1088.580714] scsi_block_when_processing_errors: rtn: 1
[ 1088.580727] scsi_add_timer: scmd: ffff88021d474e40, time: 7500, 
(ffffffffa006f521)
[ 1088.580731] scsi_delete_timer: scmd: ffff88021d474e40, rtn: 1
[ 1089.011690] scsi_block_when_processing_errors: rtn: 1
[ 1089.011754] scsi_block_when_processing_errors: rtn: 1
[ 1089.011757] scsi_block_when_processing_errors: rtn: 1
[ 1089.012053] scsi_block_when_processing_errors: rtn: 1
[ 1089.012056] scsi_block_when_processing_errors: rtn: 1
[ 1089.012069] scsi_add_timer: scmd: ffff88021d91b980, time: 7500, 
(ffffffffa006f521)
[ 1089.012075] scsi_delete_timer: scmd: ffff88021d91b980, rtn: 1
[ 1089.507506] scsi_add_timer: scmd: ffff88021d474e40, time: 60000, 
(ffffffffa006f521)
[ 1149.503878] Waking error handler thread
[ 1149.503883] Error handler scsi_eh_0 waking up
[ 1149.503903] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 
frozen
[ 1149.503909] ata1.00: cmd ca/00:70:ff:5e:00/00:00:00:00:00/e0 tag 0 
dma 57344 out
[ 1149.503911]          res 40/00:00:01:4f:c2/00:00:00:00:00/00 Emask 
0x4 (timeout)
[ 1149.503919] ata1.00: status: { DRDY }
[ 1154.552602] ata1: link is slow to respond, please be patient (ready=0)
[ 1159.550330] ata1: device not ready (errno=-16), forcing hardreset
[ 1159.550336] ata1: soft resetting link
[ 1164.750045] ata1: link is slow to respond, please be patient (ready=0)
[ 1168.108894] ata1.00: configured for UDMA/133
[ 1168.108905] scsi_eh_0: flush retry cmd: ffff88021d474e40
[ 1168.108909] ata1: EH complete
[ 1168.108913] scsi_restart_operations: waking up host to restart
[ 1168.108917] scsi_add_timer: scmd: ffff88021d474e40, time: 60000, 
(ffffffffa006f521)
[ 1168.109002] Error handler scsi_eh_0 sleeping
[ 1168.129442] scsi_delete_timer: scmd: ffff88021d474e40, rtn: 1
[ 1168.129460] scsi_add_timer: scmd: ffff88021d4f9440, time: 30000, 
(ffffffffa006f521)
[ 1168.129464] scsi_delete_timer: scmd: ffff88021d4f9440, rtn: 1
[ 1168.129469] scsi_add_timer: scmd: ffff88021d4f91c0, time: 60000, 
(ffffffffa006f521)
[ 1168.129973] scsi_delete_timer: scmd: ffff88021d4f91c0, rtn: 1
[ 1168.129987] scsi_add_timer: scmd: ffff88021d4f9440, time: 30000, 
(ffffffffa006f521)
[ 1168.129991] scsi_delete_timer: scmd: ffff88021d4f9440, rtn: 1
[ 1168.130003] scsi_add_timer: scmd: ffff88021d4f91c0, time: 60000, 
(ffffffffa006f521)
[ 1168.130007] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors 
(500108 MB)
[ 1168.130384] scsi_delete_timer: scmd: ffff88021d4f91c0, rtn: 1
[ 1168.130393] scsi_add_timer: scmd: ffff88021d474e40, time: 30000, 
(ffffffffa006f521)
[ 1168.130397] scsi_delete_timer: scmd: ffff88021d474e40, rtn: 1
[ 1168.130405] scsi_add_timer: scmd: ffff88021d4f91c0, time: 60000, 
(ffffffffa006f521)
[ 1168.130458] sd 0:0:0:0: [sda] Write Protect is off
[ 1168.130460] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[ 1168.130928] scsi_delete_timer: scmd: ffff88021d4f91c0, rtn: 1
[ 1168.130938] scsi_add_timer: scmd: ffff88021d474e40, time: 30000, 
(ffffffffa006f521)
[ 1168.130942] scsi_delete_timer: scmd: ffff88021d474e40, rtn: 1
[ 1168.130951] scsi_add_timer: scmd: ffff88021d4f91c0, time: 60000, 
(ffffffffa006f521)
[ 1168.131462] scsi_delete_timer: scmd: ffff88021d4f91c0, rtn: 1
[ 1168.131471] scsi_add_timer: scmd: ffff88021d4f9940, time: 30000, 
(ffffffffa006f521)
[ 1168.131475] scsi_delete_timer: scmd: ffff88021d4f9940, rtn: 1
[ 1168.131482] scsi_add_timer: scmd: ffff88021d4f91c0, time: 60000, 
(ffffffffa006f521)
[ 1168.131532] sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[ 1168.131899] scsi_delete_timer: scmd: ffff88021d4f91c0, rtn: 1
[ 1168.131903] scsi_block_when_processing_errors: rtn: 1
[ 1168.131907] scsi_add_timer: scmd: ffff88021d4f9940, time: 60000, 
(ffffffffa006f521)
[ 1168.131969] scsi_block_when_processing_errors: rtn: 1
[ 1168.131971] scsi_block_when_processing_errors: rtn: 1
[ 1168.132259] scsi_block_when_processing_errors: rtn: 1
[ 1168.132260] scsi_block_when_processing_errors: rtn: 1
[ 1168.132343] scsi_delete_timer: scmd: ffff88021d4f9940, rtn: 1
[ 1168.132352] scsi_add_timer: scmd: ffff88021d4f9800, time: 60000, 
(ffffffffa006f521)
[ 1168.132854] scsi_delete_timer: scmd: ffff88021d4f9800, rtn: 1
[ 1168.132862] scsi_add_timer: scmd: ffff88021d4f9940, time: 7500, 
(ffffffffa006f521)
[ 1168.132865] scsi_delete_timer: scmd: ffff88021d4f9940, rtn: 1
[ 1168.132889] scsi_add_timer: scmd: ffff88021d4f9940, time: 60000, 
(ffffffffa006f521)
[ 1168.133297] scsi_delete_timer: scmd: ffff88021d4f9940, rtn: 1
[ 1168.133315] scsi_add_timer: scmd: ffff88021d4f9940, time: 60000, 
(ffffffffa006f521)
[ 1168.133737] scsi_delete_timer: scmd: ffff88021d4f9940, rtn: 1
[ 1168.133798] scsi_add_timer: scmd: ffff88021d4f9940, time: 60000, 
(ffffffffa006f521)
[ 1168.134198] scsi_delete_timer: scmd: ffff88021d4f9940, rtn: 1
[ 1168.134220] scsi_add_timer: scmd: ffff88021d4f9940, time: 60000, 
(ffffffffa006f521)
[ 1168.134740] scsi_delete_timer: scmd: ffff88021d4f9940, rtn: 1
[ 1168.134762] scsi_add_timer: scmd: ffff88021d4f9800, time: 60000, 
(ffffffffa006f521)
[ 1168.135126] scsi_block_when_processing_errors: rtn: 1
[ 1168.135182] scsi_delete_timer: scmd: ffff88021d4f9800, rtn: 1
[ 1168.135206] scsi_block_when_processing_errors: rtn: 1
[ 1168.135208] scsi_block_when_processing_errors: rtn: 1
[ 1168.135504] scsi_block_when_processing_errors: rtn: 1
[ 1168.135505] scsi_block_when_processing_errors: rtn: 1
[ 1168.135518] scsi_add_timer: scmd: ffff88021d4f9800, time: 7500, 
(ffffffffa006f521)
[ 1168.135522] scsi_delete_timer: scmd: ffff88021d4f9800, rtn: 1
[ 1168.135807] scsi_add_timer: scmd: ffff88021d4f9800, time: 60000, 
(ffffffffa006f521)
[ 1168.136165] scsi_delete_timer: scmd: ffff88021d4f9800, rtn: 1
