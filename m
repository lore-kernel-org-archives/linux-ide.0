From: Tejun Heo <htejun@gmail.com>
Subject: Re: Cannot detect SATA disks w/ CONFIG_SATA_PMP w/o actually using
 SATA multiplier
Date: Thu, 02 Dec 2010 11:31:12 +0100
Message-ID: <4CF77570.9000700@gmail.com>
References: <AANLkTi=kbTcq3hYBiDzGcAb02Ppwb1QEcs12-1W_T=LG@mail.gmail.com>	<4CF50574.6000706@gmail.com>	<AANLkTi=0gBcfrAyJNb0+=obH2QDsqhGM5a9xxwHAoh88@mail.gmail.com>	<4CF55549.4080000@gmail.com> <AANLkTimWqFh-PD4DFXwaRmthb5Lyw3MAFknFmT7vp5pY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:65431 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636Ab0LBKbR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Dec 2010 05:31:17 -0500
Received: by bwz15 with SMTP id 15so7084799bwz.19
        for <linux-ide@vger.kernel.org>; Thu, 02 Dec 2010 02:31:15 -0800 (PST)
In-Reply-To: <AANLkTimWqFh-PD4DFXwaRmthb5Lyw3MAFknFmT7vp5pY@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lin Mac <mkl0301@gmail.com>
Cc: cbouatmailru@gmail.com, linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello,

On 12/02/2010 11:23 AM, Lin Mac wrote:
>> One thing which could be possible is that the controller stashes the
>> result code for the PMP aware SRST according to the PMP number instead
>> of the usual place, so the driver can't see it.  In that case, the
>> driver can be modified to check both places I suppose but if the
>> hardware can be fixed, that would be great.
> the usual place, I presume you mean PxTFD+PxSIG.
> I've check RFIS of received FIS structure after softreset failed and
> nothing there. (UFIS neither)
> Is there any other suspect to check?

Have you checked all PxTFDs?  It could be that the controller is
saving it in the wrong slot.

> My situation is that device is sending D2H Reg FIS, but controller is
> not reflecting it on PxTFD, PxSIG, or RFIS of received FIS
> structure.With the patch I sent, it seems the controller receives D2H
> Reg FIS of the same PMP setting of the previous sent H2D Reg FIS, and
> drop the different one.

If the controller is dropping the D2H Reg FIS altogether, it'll
probably need more intricate workaround.  :-(

> The AHCI controller I used is AHCI v1.1 compatible, command-based switching.
> 
> In SATA spec (rev2.6) 16.7.1, it says:
> 
> A host controller may support command-based switching by implementing
> the Port Multiplier Port (PMP) field in the SControl register as
> detailed in section 14.1.3.In order to use this mechanism, host
> software would set the PMP field appropriately before issuing a
> command to a device conected to the Port Multiplier. (...) Note that
> the PMP field shall be set to the control port when host software
> issues commands to the Port Multiplier itself.
> --
> 
> In AHCI spec, the PMP field of PxSCTL "is not used by AHCI".Does it
> implies AHCI would set it and software doesn't need to do anything?
> 
> 13.13.4.1 Port Multiplier Discovery
> If  a device is present, the host issues a software reset with the PM
> Port field set  to the control port. The host checks the signature
> value returned and if....
> --
> 
> SATA spec didn't says what to do IF it received a data with PMP
> setting doesn't match it's current setting (did it?). While 13.13.4.1
> only implies the host should receive the signature successfully, even
> if it is of different PMP setting.

The probing sequence is described somewhere in the ahci spec and I'm
fairly sure the dropping behavior you're describing is out of spec.
You'll need to find a way to reliably distinguish a PMP device and
then probably implement the workaround in custom hardreset or
softreset method for the specific controller.

Good luck.

-- 
tejun
