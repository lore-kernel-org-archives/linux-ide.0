From: viresh kumar <viresh.kumar@st.com>
Subject: Re: ata: hotplug not working with arasan CF controller driver
Date: Thu, 2 Dec 2010 16:11:20 +0530
Message-ID: <4CF777D0.4010603@st.com>
References: <ede5127fb76113dd7560fa8919c0e125b38985a2.1290422728.git.viresh.kumar@st.com> <4CECA643.2010005@st.com> <4CEFED92.7050701@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eu1sys200aog110.obsmtp.com ([207.126.144.129]:44032 "EHLO
	eu1sys200aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752838Ab0LBKle (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Dec 2010 05:41:34 -0500
In-Reply-To: <4CEFED92.7050701@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 11/26/2010 10:55 PM, Tejun Heo wrote:
> You gotta tell EH that the device needs rescanning.  When you detect a
> hotplug event, call ata_ehi_hotplugged() followed by
> ata_port_freeze().

Tejun,

Do you want to say, we need to call above routines for both hotplugging
events: card insert and remove??

Actually i am getting following messages on insert:

ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen
ata1: soft resetting link
ata1.00: CFA: TRANSCEND, 20091215, max UDMA/66
ata1.00: 62537328 sectors, multi 0: LBA 
ata1.00: configured for PIO6
ata1.00: configured for PIO6
ata1: EH complete
scsi 0:0:0:0: Direct-Access     ATA      TRANSCEND        2009 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 62537328 512-byte logical blocks: (32.0 GB/29.8 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sda:
sd 0:0:0:0: Attached scsi generic sg0 type 0
 sda1
sd 0:0:0:0: [sda] Attached SCSI disk


and following messages on card remove:

ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen
ata1: soft resetting link
ata1.00: revalidation failed (errno=-2)
ata1: soft resetting link
ata1.00: revalidation failed (errno=-2)
ata1: soft resetting link
ata1.00: revalidation failed (errno=-2)
ata1.00: disabled
ata1: soft resetting link
ata1: EH complete
ata1.00: detaching (SCSI 0:0:0:0)
sd 0:0:0:0: [sda] Stopping disk
sd 0:0:0:0: [sda] START_STOP FAILED
sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00


For me, card insertion messages are fine, but I am not sure if card removal
messages are fine??

--
viresh
