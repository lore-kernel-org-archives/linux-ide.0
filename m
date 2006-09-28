From: "Eric D. Mudama" <edmudama@gmail.com>
Subject: Re: [PATCH REPOST] libata: lengthen interval between SRST set and clear
Date: Thu, 28 Sep 2006 14:11:39 -0600
Message-ID: <311601c90609281311q4feb90f1w402a283aecfcbc3e@mail.gmail.com>
References: <20060928091334.GM25800@htj.dyndns.org>
	 <451B9B90.5020009@pobox.com> <451B9C91.3030106@gmail.com>
	 <451B9D35.6040405@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:13638 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751990AbWI1ULk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Sep 2006 16:11:40 -0400
Received: by nf-out-0910.google.com with SMTP id o25so819279nfa
        for <linux-ide@vger.kernel.org>; Thu, 28 Sep 2006 13:11:39 -0700 (PDT)
In-Reply-To: <451B9D35.6040405@pobox.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, justin@jmicron.com, linux-ide@vger.kernel.org

On 9/28/06, Jeff Garzik <jgarzik@pobox.com> wrote:
> Given the minimal amount of problem reports, I'd rather hold off and
> collect data.  What devices are affected?  Is it complaining because
> it's in the middle of a reset when SRST is received?  Is it just one
> model of one device?  Is this definitely reproducible on all SATA
> controllers?  etc.
>
> Too many unknowns right now...
>
>         Jeff

I agree 100%.  The specification states in section 13.1.1 of the 2.5
SATA specification covering Parallel ATA Emulation for Software Reset:

"Although host software is required to toggle the SRST bit no faster
than 5 us, devices may not rely on the inter-arrival time of received
Register =96 Host to Device FISes also meeting this timing. Because of
flow control, frame handshaking, and other protocol interlocks,
devices may effectively receive the resulting Register =96 Device to
Host FISes back-to-back."

Is it possible that the "set" of SRST hasn't actually occurred on the
bus when the "clear" of SRST is issued to the controller?  If that's
the case, then the right answer should be using a mechanism to confirm
transmission of the HTD register FIS before generating the clear for
SRST.  I'm guessing this is basically looking for R_OK from the
device.

Drive firmware has to cope with these latencies (as well as
collisions, especially in NCQ), so surely there's a safe way to do it
in the various controllers.

--eric
