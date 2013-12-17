From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 6/6] libata: return power status in REQUEST SENSE command
Date: Tue, 17 Dec 2013 21:02:46 +0300
Message-ID: <52B091C6.4050106@cogentembedded.com>
References: <cover.1384030893.git.psusi@ubuntu.com> <1387236657-4852-1-git-send-email-psusi@ubuntu.com> <1387236657-4852-7-git-send-email-psusi@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <1387236657-4852-7-git-send-email-psusi@ubuntu.com>
Sender: linux-scsi-owner@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>, todd.e.brandt@linux.intel.com
Cc: tj@kernel.org, JBottomley@parallels.com, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello.

On 12/17/2013 02:30 AM, Phillip Susi wrote:

> SAT-3 says REQUEST SENSE should issue CHECK POWER and return
> a sense status indicating the drive's power status.
> ---
>   drivers/ata/libata-scsi.c | 40 ++++++++++++++++++++++++++++++++++------
>   1 file changed, 34 insertions(+), 6 deletions(-)

> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index f92eb21..8b17352 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -3313,6 +3313,38 @@ static unsigned int ata_scsi_mode_select_xlat(struct ata_queued_cmd *qc)
>   	return 1;
>   }
>
> +static void ata_scsi_request_sense_complete(struct ata_queued_cmd *qc)
> +{
> +	struct scsi_cmnd *cmd = qc->scsicmd;

    Please insert empty line here, after declaration.

> +	cmd->result = (DRIVER_SENSE << 24);

    () not needed.

> +	if (qc->result_tf.nsect == 0)
> +		/* POWER STATE CHANGE TO STANDBY */
> +	{

    Wrong *if* style, should be "*if* () {" on the same line.

> +		scsi_build_sense_buffer(0, cmd->sense_buffer, 0, 0x5E, 0x43);
> +	}
> +	else scsi_build_sense_buffer(0, cmd->sense_buffer, 0, 0, 0);

    Wrong style again, scsi_build_sense_buffer() should be on its own line, 
and {} must be used in both branches of *if* if used in one.

> +	qc->scsidone(cmd);
> +	ata_qc_free(qc);
> +}
> +
> +/**
> + *	ata_scsi_request_sense_xlat - Simulate REQUEST SENSE command
> + *	@qc: Storage for translated ATA taskfile
> + *
> + *	Converts a REQUEST SENSE command to an ATA CHECK POWER MODE taskfile.
> + *
> + *	LOCKING:
> + *	spin_lock_irqsave(host lock)
> + */
> +static unsigned int ata_scsi_request_sense_xlat(struct ata_queued_cmd *qc)
> +{
> +	qc->tf.command = ATA_CMD_CHK_POWER;

    Isn't it an optional command, belonging to the power management feature set?

WBR, Sergei

