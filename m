From: Tyler <pml@dtbb.net>
Subject: Increase IDE Drive letters beyond dev/hdz to dev/hdaa, similar to
 scsi drive lettering
Date: Sat, 30 Apr 2005 04:04:59 -0700
Message-ID: <4273665B.9070208@dtbb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound01.telus.net ([199.185.220.220]:49577 "EHLO
	priv-edtnes56.telusplanet.net") by vger.kernel.org with ESMTP
	id S261196AbVD3LHC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Apr 2005 07:07:02 -0400
Received: from [192.168.0.28] (really [142.179.55.145])
          by priv-edtnes56.telusplanet.net
          (InterMail vM.6.01.04.04 201-2131-118-104-20050224) with ESMTP
          id <20050430110658.CVBQ10290.priv-edtnes56.telusplanet.net@[192.168.0.28]>
          for <linux-ide@vger.kernel.org>; Sat, 30 Apr 2005 05:06:58 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Is there a simple way to patch the ide driver to support drive letters 
beyond dev/hdz, to roll over to hdaa,hdab, etc?  The scsi drive 
lettering currently does this.. going sda to sdz, then sdaa,sdab,sdac, etc.

The reason I need this is for using 4 x Highpoint 454 (hpt374 chipset, 8 
drives each card) PATA cards in a software md raid, but of course it 
runs out of drive letters, and starts using funny characters such as 
dev/hd{ , and dev/hd\207 or something..

Beyond that, is there a way to merge hpt36x/hpt374 chipset support into 
libata, since libata uses scsi emulation with scsi drive lettering?  It 
seems that is a goal of libata anyways, to support older PATA chipsets 
as well.

And, yet one more option, would be to choose in the kernel config, 
whether you want the hpt374 driver to use ide, or scsi emulation.. 
currently, the tainted proprietary driver directly from highpoint uses 
scsi emulation.. surely it could merged as an option for the driver 
thats included in the kernel?

Regards,
Tyler Guthrie.
