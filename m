From: "Miguel Medalha" <miguelmedalha@sapo.pt>
Subject: Re: Disk errors reported on boot - kernel 2.6.18
Date: Sat, 16 Jun 2007 16:08:39 +0100
Message-ID: <002101c7b028$38bab8d0$0901a8c0@medalha>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="Windows-1252";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:48359 "HELO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1757219AbXFPPIz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 16 Jun 2007 11:08:55 -0400
Received: from unknown (HELO medalha) (miguelmedalha@sapo.pt@[82.155.48.77])
          (envelope-sender <miguelmedalha@sapo.pt>)
          by mta15 (qmail-ldap-1.03) with SMTP
          for <linux-ide@vger.kernel.org>; 16 Jun 2007 15:08:51 -0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

After my previous message on the same subject, I thought it would be useful 
to report the following:

I recently installed a new disk on the same computer. This one is a Hitchi 
HDS721616PLAT80.

When this disk is connected to the ICH5 controller, the following error 
lines appear on boot:

-------------------------------------------------------------------
hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hda: drive_cmd: error=0x04 { DriveStatusError }
ide: failed opcode was: 0xb0
-------------------------------------------------------------------

The drive is working perfectly. I even verified it with a tool provided by 
the manufacturer. SMART also does not report any error .
The same disk gives no error whatsoever when connected to a ITE8212 IDE 
Controler present on the same computer.

The overall configuration of this machine was given on my previous post.

Thank you for your attention.
Best regards
Miguel 

