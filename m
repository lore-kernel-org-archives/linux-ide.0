From: Tim Small <tim@seoss.co.uk>
Subject: Re: SiI 3726 pmp doesn't work with 2.6.38 and Marvell 88SE9123 AHCI
 controller
Date: Thu, 07 Jul 2011 13:13:37 +0100
Message-ID: <4E15A2F1.7080106@seoss.co.uk>
References: <4DEE6831.9020501@seoss.co.uk> <20110609143755.GA2615@htj.dyndns.org> <4DF136FF.2010404@seoss.co.uk> <20110610102403.GE15235@htj.dyndns.org> <4DF249BB.3040808@seoss.co.uk> <4E14C6ED.5040208@buttersideup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay0.allsecurenet.com ([109.169.27.60]:59187 "EHLO
	relay0.allsecurenet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755856Ab1GGMNn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Jul 2011 08:13:43 -0400
In-Reply-To: <4E14C6ED.5040208@buttersideup.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Hubert Bailey <hbailey@marvell.com>, lil@marvell.com
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

A few more data points on this issue:

I've tried the 88SE9123 and the 88SE9125 card in a Windows XP machine (a
relatively slow PCI-e gen1 box), and have these results:

2x 2G Hitachi drives connected via a SiI 3726, and to a SiI 3132: works
for simultaneous reads with hdparm (for Windows -
http://hdparm-win32.dyndns.org/hdparm/ - simultaneous read done with
"start /b hdparm -t /dev/sdb & hdparm -t /dev/sdc" at windows command
prompt) - read speeds at 60M per second on both drives.  Reads from a
single drive at 115M per second.  Reads from a single drive (direct to
host, not via PMP) at 117M per second.


2x 2G Hitachi drives connected via a SiI 3726, and to a SiI 3132 (Debian
6.0 2.6.32 NCQ depth any) - works for simultaneous reads with hdparm -
read speeds at 60M per second on both drives.  Reads from a single drive
at 122M per second.  Reads from a single drive (direct to host, not via
PMP) at 121M per second.



2x 2G Hitachi drives connected via a SiI 3726, and to the 88SE9123 card
(Windows XP mv91xx.sys v1.1.0.6 14-Feb-2011 ) - works for simultaneous
reads with hdparm - read speeds at 60M per second on both drives.  Reads
from a single drive at 117M per second.  Reads from a single drive
(direct to host, not via PMP) at 130M per second.


2x 2G Hitachi drives connected via a SiI 3726, and to the 88SE9123 card
( Debian 6.0  2.6.32 NCQ depth 31 - same with any value between 2 and 31
) - works for simultaneous reads with hdparm - read speeds at 30M per
second on both drives.  Reads from a single drive at 130M per second. 
Reads from a single drive (direct to host, not via PMP) at 130M per second.


2x 2G Hitachi drives connected via a SiI 3726, and to the 88SE9123 card
( Debian 6.0  2.6.32 NCQ depth 1 ) - works for simultaneous reads with
hdparm - read speeds at 60M per second on both drives.  Reads from a
single drive at 130M per second.  Reads from a single drive (direct to
host, not via PMP) at 130M per second.



2x 2G Hitachi drives connected via a SiI 3726, and to the 88SE9125 card
( Debian 6.0  2.6.32 NCQ depth 31  - same with any value between 2 and
31 ) - works for simultaneous reads with hdparm - read speeds at 31M per
second on both drives.  Reads from a single drive at between 19M per
second and 130M per second with NCQ depth = 31 (most often 130M), but
reads from a single drive with NCQ depth = 2 varied between 5M per
second and 54M per second.  Reads from a single drive (direct to host,
not via PMP) at 130M per second (127M per second with depth = 2).


2x 2G Hitachi drives connected via a SiI 3726, and to the 88SE9125 card
( Debian 6.0  2.6.32 NCQ 1 ) - works for simultaneous reads with hdparm
- read speeds at 60M per second on both drives.  Reads from a single
drive at 130M per second.  Reads from a single drive (direct to host,
not via PMP) at 126M per second (consistantly 3M per second slower than
via PMP!).


Gotta dash, more testing later...

Tim.

-- 
South East Open Source Solutions Limited
Registered in England and Wales with company number 06134732.  
Registered Office: 2 Powell Gardens, Redhill, Surrey, RH1 1TQ
VAT number: 900 6633 53  http://seoss.co.uk/ +44-(0)1273-808309

