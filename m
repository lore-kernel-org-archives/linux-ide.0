From: Tim Small <tim@seoss.co.uk>
Subject: Western Digital Velociraptor WD740ADFD-00NLR5 - NCQ performance falls
 off a cliff wi queue depth greater than two
Date: Mon, 12 Oct 2009 15:18:48 +0100
Message-ID: <4AD33AC8.6000505@seoss.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay1.allsecurenet.com ([63.246.152.102]:46439 "EHLO
	relay1.allsecurenet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756682AbZJLPAV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Oct 2009 11:00:21 -0400
Received: from [78.105.152.189] (helo=zebedee.buttersideup.com)
	by relay1.allsecurenet.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <tim@seoss.co.uk>)
	id 1MxLjc-0000kX-FT
	for linux-ide@vger.kernel.org; Mon, 12 Oct 2009 14:18:48 +0000
Received: from [91.208.163.30] (ermintrude [91.208.163.30])
	by zebedee.buttersideup.com (Postfix) with ESMTP id 901359B8F5
	for <linux-ide@vger.kernel.org>; Mon, 12 Oct 2009 15:18:46 +0100 (BST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I have what looks like a firmware or design performance bug with some 
74G WD Velociraptors WD740ADFD-00NLR5 (firmware 21.07QR5).  Sequential 
read speed (as measured with 'hdparm -t') drops-off with NCQ depths 
greater than 2.

Queue-depth(cmds) Speed(MB/s)

1   84
2   84
3   46
5   39
10   39
20   44
31   36

The speed given is the best of 10 - the system was under light load (I 
couldn't completely unload it, unfortunately).

Western Digital helpfully suggested that I contact my Linux vendor...


The system is a Tyan server with a Core2Quad Q6600  @ 2.40GHz, and an 
ICH9 running Debian 5.0 - kernel 2.6.26-2-openvz-amd64, SATA ports in 
non-RAID/AHCI/native mode.

I measured the speed like this:

for i in {1..31} ; do echo $i > /sys/block/sda/device/queue_depth ; echo 
-n "$( cat /sys/block/sda/device/queue_depth | head -c -1 )," ; for j in 
{1..10} ; do (hdparm -t /dev/sda | egrep -o 
'[[:digit:]]+\.[[:digit:]]+[[:space:]]+MB/sec' | head -c -1 ) ; done ; 
echo ; done | sed 's/ MB\/sec/,/g'

... and created a chart and max speed data in openoffice:

http://buttersideup.com/files/wd-raptor-NCQ-bug-1.pdf

with a second run here:

http://buttersideup.com/files/wd-raptor-NCQ-bug-2.pdf

Any comments or suggestions welcome - I'd be happy to repeat the test 
using a different benchmark if anyone can suggest a command-line they'd 
like run?

Cheers,

Tim.

-- 
South East Open Source Solutions Limited
Registered in England and Wales with company number 06134732.  
Registered Office: 2 Powell Gardens, Redhill, Surrey, RH1 1TQ
VAT number: 900 6633 53  http://seoss.co.uk/ +44-(0)1273-808309

