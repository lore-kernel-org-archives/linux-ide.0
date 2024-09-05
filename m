Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2188C13D638;
	Thu,  5 Sep 2024 19:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725564521; cv=none; b=on5DCKV8YtbUQzRXIzCh0vOJhQv1KRM1eUSURBCOwNpGTivHo5Iybyi6gMHM+s1wa2iNH3gADrxpqUo31yGATZ7JlTMOhDtgV0EtAJQgRxbQKqeb177U4JhFWYaXQ2c4IMHNkjwgiZ5iNB8CUNP/7CruzR3JqWoL0tNOJ2mpJUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725564521; c=relaxed/simple;
	bh=xSCNcyZPAD7C2Zf/moV/PmenKrSqHCwAipxM+ngnN60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NE+bHCi0nr2dCSxQ/Gb4y3lqM8nW2nEsAzzz/+WlMC9s0tfYuyAq4i3J1zfEPCWo+YlgJ27MhFquzesx+WXOt+IfmDv35YD7EN5SJtFWGEf6ujGOi24vIu0U2HDAV+RdsXRT9EpLx1wd06zjkStuh9vNO6GiKyZsWxfJ/VIAjkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vl/erQi1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vl/erQi1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 273E5C4CEC3;
	Thu,  5 Sep 2024 19:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725564518;
	bh=xSCNcyZPAD7C2Zf/moV/PmenKrSqHCwAipxM+ngnN60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vl/erQi1rk5yk7gH3N27H1rDqGA2UA4gSe4LCir9XZc2fGvbWMuIRoigfPPvyDObT
	 HZ1ESxLaFbrEHA7aLp4zfU54ro6RZD/w351OBuOAGQ2uuzKV+zmT3dT5K7+1s1597r
	 rmIK42612TxgaFSC8Ek+v9rgdmz9K7sVqudUY0IVpNCwMyARjwmazsU/kAYl+vheWc
	 CdHEfBfy/PsbfFPnFIsAH48QJs/2hTpGYhRc+brihP9Os8WSYbQ8O6cTAMwZBk9ym8
	 3a2LawmKhv74OHCWST1iJkPEhwBsWipd3Ug9SGwz4rncZF2oSfNttAyZy2c8hge0Nx
	 sFylnzxsCeZqw==
Date: Thu, 5 Sep 2024 21:28:34 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: libata-eh: Clear scsicmd->result when setting
 SAM_STAT_CHECK_CONDITION
Message-ID: <ZtoGYshL26jTuTOj@ryzen.lan>
References: <20240904223727.1149294-1-ipylypiv@google.com>
 <Ztls4mim6Jky7E0S@ryzen.lan>
 <Ztl5I1Kz53MOEtF4@ryzen.lan>
 <ZtmmvNYxkQGZwVwy@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtmmvNYxkQGZwVwy@ryzen.lan>

On Thu, Sep 05, 2024 at 02:40:28PM +0200, Niklas Cassel wrote:
> Anyway, I think I came up with an even nicer patch to clear the driver byte.
> 
> Change ata_scsi_set_sense():
> -to set SENSE_DATA_VALID
> -to clear driver byte (if scsicmd)
> 
> For the cases that calls:
> -scsi_build_sense_buffer()
> (because they don't want to set the SAM_STAT_CHECK_CONDITION)
> or
> -scsi_build_sense()
> without using ata_scsi_set_sense():
> create a new function/functions (e.g. ata_build_sense_keep_status())
> -sets SENSE_DATA_VALID
> -clears driver byte (if scsicmd)
> 
> Will send a PATCH/RFC series today or tomorrow.

Thinking even more about this:

ata_qc_schedule_eh() will have called scsi_timeout(), which sets
DID_TIME_OUT, since libata does not have an abort handler.

Thus, the command when first entering EH will have DID_TIME_OUT set.
Right now, we clear it as the final thing in ata_scsi_qc_complete().
You are suggesting that we clear it when storing sense data.

However:
There can always be commands that was sent via EH, that will not
have added sense data, e.g. for CDL policy 0xD commands that were
completed in the same IRQ (where some commands might have sense
data, but not all), same with NCQ error, one command will be the
one that triggered the NCQ error, rest will not have sense data.
Thus we will always need to clear the DID_TIME_OUT bit for commands
that were sent via EH...

I think what we could do, is to clear it when first entering EH,
instead of at the end of EH. This is probably the best solution,
because then we can remove the:
cmd->result &= 0x0000ffff;
from ata_scsi_qc_complete(), which is executed both for commands
that went via EH and command that did not go via EH.

And instead clear it in the beginning of EH, so DID_TIME_OUT will
only get cleared for commands that went via EH. (Because only
commands that went via EH will have DID_TIME_OUT set in the first
place.)



So my proposal is simply this:

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 7de97ee8e78b..450e9bd96c97 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -630,6 +630,15 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
        list_for_each_entry_safe(scmd, tmp, eh_work_q, eh_entry) {
                struct ata_queued_cmd *qc;
 
+               /*
+                * If the scmd was added to EH, via ata_qc_schedule_eh() ->
+                * scsi_timeout() -> scsi_eh_scmd_add(), scsi_timeout() will
+                * have set DID_TIME_OUT (since libata does not have an abort
+                * handler). Thus to clear the DID_TIME_OUT, we clear the host
+                * byte (but keep the SCSI ML and status byte).
+                */
+               scmd->result &= 0x0000ffff;
+
                ata_qc_for_each_raw(ap, qc, i) {
                        if (qc->flags & ATA_QCFLAG_ACTIVE &&
                            qc->scsicmd == scmd)
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 3a442f564b0d..6a90062c8b55 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1680,9 +1680,6 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
                        set_status_byte(qc->scsicmd, SAM_STAT_CHECK_CONDITION);
        } else if (is_error && !have_sense) {
                ata_gen_ata_sense(qc);
-       } else {
-               /* Keep the SCSI ML and status byte, clear host byte. */
-               cmd->result &= 0x0000ffff;
        }
 
        ata_qc_done(qc);



Testing is appreciated :)

Thoughts?


Kind regards,
Niklas
