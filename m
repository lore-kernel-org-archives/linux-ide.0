Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B97911CB8;
	Sun, 16 Jun 2024 23:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718581032; cv=none; b=C+fhtErQPR60XrwdL5LNoeGpxeP4mG9OlhEwwsj02b8lD5uIdYA8V/l15HUzA/L3bH1CstYjfSmqYRgcVhcZNOzO+L6pXIGTlhY3NAb1eTGZGJIF6uiUpwn9iEO4ie/eAJLBJp27t37jdyUO1raPFN6p6ohzvgoxu14SYc5FpdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718581032; c=relaxed/simple;
	bh=pRTMT5KMR1XYj0FPvcEM5a56UTjJkcLIq5xWEajd2ZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YK5/jW/b+cB3nK/OBN+8hAV1OmZzyhtwsT6FKj9J8ebwILL8o73B53/fB+4fwdiY1nKivWZzbk0CKoga+fOO+be1yT41fzjMf0YUSQu60eOpftH+RarUIlabMTiAuOp9FP4/trXEiAZZOIY2OO263M0EX1REsZkQ4OoSYy32rm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b73XNBCn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b73XNBCn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87241C2BBFC;
	Sun, 16 Jun 2024 23:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718581031;
	bh=pRTMT5KMR1XYj0FPvcEM5a56UTjJkcLIq5xWEajd2ZM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=b73XNBCnDKSAwGOIRaHgLoNceO/8DD+dtOnmK2S817mkjGPQJta4k5dD/U2/np3Bx
	 v6vedXeya250Gbm3avbdwuREKU2u5euasrwczTxeObK59cgyPJzD9cOsmQSmm3WlA2
	 fLl08QSSZua47ZNI5nvDCiDz81rhuTlD3C1uREnOzv0AExbfYQpiym2wb1m/O+Hwkw
	 bL3LFarm1Tj9wZMBC0QvaAS3FBcZdlIl3BK4OWUwQg+IESSTU8qfqtsaRFu4eFA91n
	 jVvmwoQjoCr3VrYu5CiZmfC0tZpQwTs4JSOAVHX587etfJu07vc11SX4xVFj36ggsG
	 5qmpJOcFA6XtA==
Message-ID: <6ce12728-c9a4-4780-af55-69674e510c12@kernel.org>
Date: Mon, 17 Jun 2024 08:37:09 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] ata: libata-scsi: Fix offsets for the fixed format
 sense data
To: Igor Pylypiv <ipylypiv@google.com>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 Akshat Jain <akshatzen@google.com>
References: <20240614191835.3056153-1-ipylypiv@google.com>
 <20240614191835.3056153-5-ipylypiv@google.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240614191835.3056153-5-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/15/24 04:18, Igor Pylypiv wrote:
> Correct the ATA PASS-THROUGH fixed format sense data offsets to conform
> to SPC-6 and SAT-5 specifications. Additionally, set the VALID bit to
> indicate that the INFORMATION field contains valid information.
> 
> INFORMATION
> ===========
> 
> SAT-5 Table 212 — "Fixed format sense data INFORMATION field for the ATA
> PASS-THROUGH commands" defines the following format:
> 
> +------+------------+
> | Byte |   Field    |
> +------+------------+
> |    0 | ERROR      |
> |    1 | STATUS     |
> |    2 | DEVICE     |
> |    3 | COUNT(7:0) |
> +------+------------+
> 
> SPC-6 Table 48 - "Fixed format sense data" specifies that the INFORMATION
> field starts at byte 3 in sense buffer resulting in the following offsets
> for the ATA PASS-THROUGH commands:
> 
> +------------+-------------------------+
> |   Field    |  Offset in sense buffer |
> +------------+-------------------------+
> | ERROR      |  3                      |
> | STATUS     |  4                      |
> | DEVICE     |  5                      |
> | COUNT(7:0) |  6                      |
> +------------+-------------------------+
> 
> COMMAND-SPECIFIC INFORMATION
> ============================
> 
> SAT-5 Table 213 - "Fixed format sense data COMMAND-SPECIFIC INFORMATION
> field for ATA PASS-THROUGH" defines the following format:
> 
> +------+-------------------+
> | Byte |        Field      |
> +------+-------------------+
> |    0 | FLAGS | LOG INDEX |
> |    1 | LBA (7:0)         |
> |    2 | LBA (15:8)        |
> |    3 | LBA (23:16)       |
> +------+-------------------+
> 
> SPC-6 Table 48 - "Fixed format sense data" specifies that
> the COMMAND-SPECIFIC-INFORMATION field starts at byte 8
> in sense buffer resulting in the following offsets for
> the ATA PASS-THROUGH commands:
> 
> Offsets of these fields in the fixed sense format are as follows:
> 
> +-------------------+-------------------------+
> |       Field       |  Offset in sense buffer |
> +-------------------+-------------------------+
> | FLAGS | LOG INDEX |  8                      |
> | LBA (7:0)         |  9                      |
> | LBA (15:8)        |  10                     |
> | LBA (23:16)       |  11                     |
> +-------------------+-------------------------+
> 
> Reported-by: Akshat Jain <akshatzen@google.com>
> Fixes: 11093cb1ef56 ("libata-scsi: generate correct ATA pass-through sense")
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>  drivers/ata/libata-scsi.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 4bfe47e7d266..8588512f5975 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -855,7 +855,6 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
>  	struct scsi_cmnd *cmd = qc->scsicmd;
>  	struct ata_taskfile *tf = &qc->result_tf;
>  	unsigned char *sb = cmd->sense_buffer;
> -	unsigned char *desc = sb + 8;
>  	u8 sense_key, asc, ascq;
>  
>  	if (qc->flags & ATA_QCFLAG_SENSE_VALID) {
> @@ -880,8 +879,9 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
>  		scsi_build_sense(cmd, 1, RECOVERED_ERROR, 0, 0x1D);
>  	}
>  
> -	if ((cmd->sense_buffer[0] & 0x7f) >= 0x72) {
> +	if ((sb[0] & 0x7f) >= 0x72) {
>  		u8 len;
> +		unsigned char *desc;

Please move this declaration before the "u8 len" one.
Otherwise, this seems OK but needs a Cc: stable@vger.kernel.org tag added.

>  
>  		/* descriptor format */
>  		len = sb[7];
> @@ -919,21 +919,21 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
>  		}
>  	} else {
>  		/* Fixed sense format */
> -		desc[0] = tf->error;
> -		desc[1] = tf->status;
> -		desc[2] = tf->device;
> -		desc[3] = tf->nsect;
> -		desc[7] = 0;
> +		sb[0] |= 0x80;
> +		sb[3] = tf->error;
> +		sb[4] = tf->status;
> +		sb[5] = tf->device;
> +		sb[6] = tf->nsect;
>  		if (tf->flags & ATA_TFLAG_LBA48)  {
> -			desc[8] |= 0x80;
> +			sb[8] |= 0x80;
>  			if (tf->hob_nsect)
> -				desc[8] |= 0x40;
> +				sb[8] |= 0x40;>  			if (tf->hob_lbal || tf->hob_lbam || tf->hob_lbah)
> -				desc[8] |= 0x20;
> +				sb[8] |= 0x20;
>  		}
> -		desc[9] = tf->lbal;
> -		desc[10] = tf->lbam;
> -		desc[11] = tf->lbah;
> +		sb[9] = tf->lbal;
> +		sb[10] = tf->lbam;
> +		sb[11] = tf->lbah;
>  	}
>  }
>  

-- 
Damien Le Moal
Western Digital Research

