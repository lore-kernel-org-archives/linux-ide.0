Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B0E15B998
	for <linux-ide@vger.kernel.org>; Thu,  9 Jul 2026 02:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783563896; cv=none; b=AiLICA6x0I8oJggId3T7xpZhuMq0bImlNYnQQMfcvg2XxUV6EkigxVIlRX2gWMqN8B9+NyTTXILa+9sXLc+Mn5iRsSyNnReVuBoJ5C7GeM5NrzDaGEdYnNOhwB9UgGLZaKa4c7FVEDRvNrgmhxx+lWtrIOhqnE4po/IPaLBlkos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783563896; c=relaxed/simple;
	bh=9cfKziMH86NDrQ5YDfwVI4Dz010TtVsxJHJZZuqzXkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgbePLEGQkXICIDbC77VTvPGT0BPZ020wAsCRzMHu2PVMLQOFS4s6IeNuT62YgnPT5adoAlVOmyneZ18wJfFDqjA86TP0jqA90chMFX426DkO/47NKC/ZClxTOZ9La6nDh5Jl87IO54n/3Ye2D7AWRhbV0czCZhEhU+yx+Rnuek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IwfJGxQW; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IwfJGxQW"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cb59f6ba26so58805ad.0
        for <linux-ide@vger.kernel.org>; Wed, 08 Jul 2026 19:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783563894; x=1784168694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TNbWlyVjmD3Y4bikHUItloVHnS6u78fK2qgRkCFP1lI=;
        b=IwfJGxQWO4yMr2P1gdP8i8XjEiJ79DAzIRSa2lrGpTQ716CphbZsIG78Yzn8eUdrZW
         MrwIMD3kyl+ZPqo607J4QuWEKzL/Ionwgj/6N6w8U8pGsfhuocNxJ6/lQh3BV93ZCteg
         gk5lFvaFOueKvVsOd8lJfWrLI64Aww8kwJxJl4yJSHWNdw7xFuN/hfy5lbn2/aqMqTGe
         b1ka83UaAIa0OPBErc2yJYZ2XXD5YGimAffDCuhLF2lxb5hIDZmqbnASuOKkuwKiRicY
         e7wMUpa/SusZbGky4RASUnHi9mLFKl6+jpuSWMllF/Fc2EFfemgKcJoPQ4qVZ5KXW02x
         9WFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783563894; x=1784168694;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TNbWlyVjmD3Y4bikHUItloVHnS6u78fK2qgRkCFP1lI=;
        b=LP+XRlMaB33gG20kqiUqbOX18YKdM9l+kPSaXLRDRMqZWomNlkmZp9cF9xI0Dir0RM
         h46YUJ+bdjQnz85O8RUdRdZZJkYy5dgaucToMGZ6naDk4d3bowZxQ229L+28H+jwH6oC
         YRKnlFtR1aFpQHISFricCOfqE5mh51M+kljFAWHqrXDFtqHSAXV/0etr1e8G01JiSMNS
         2e/FXy1qHJGcwWbyggu6UkYyqRjcwpm61ubW6zvepxd1n0F5F6v4+DR/cUDwMh/8XvIk
         /gtXYfHmPUfRvTeMcC1uXr+ZGYkIhVJ6ZQah8IGVNNO0hPjDSQ13hmMjsgD3vlfwS6Y/
         kkdg==
X-Forwarded-Encrypted: i=1; AHgh+RqjqizGZtvbnR8oZuu8pDYMbbbII5ANIUHH/0AqYfc20LqIq105AfqnYWwjMOk3JeRUHRp8DXGac+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBCeGue34ClHjAYD0A6rHbimC2KitBzsdZ8Hqg2DYIzL3N34Vs
	9OXIx/rF5jCDKhJEvE5X+yvuyvp2Mh5TZsVgh7L6/Yd5+talUBFdndmE9BOgbxpgXQ==
X-Gm-Gg: AfdE7cnfGRb7m1mihgwYGvRDKe9DsAAyPZyQ3gKbuE6lxTbh/1EryE4VhgwpaJN0tFr
	GAq7iHSxSjv9kpVvD7SfWl39YVQ/N/1cKPosujtibq8CBd5S45amFOxu+Ip8Rp/2XEbAw89f2qV
	v+i8U2JG8KOfpaWhCcY3UG2mL4pGQt3C3hFRBr5P5clBPWZSvecruXkImIQAOlK7Xm3ylH3+FyV
	eNdLjtDX4asm8xckmo89RC7SaLfoOSQDycenu9UxHyGf+auGhRHQW15EZ8TzqqctOU9x3Jz+uy7
	JRC0VW9V2zagaH2+8qwTQEr0Hd3Og9uDMdbSJHeQK69owSUuJ5XeyxupxeyzYAx7/VTmSSCT7rF
	Bxh7kco2F9sI5GZWXs0y2N5zymAgbwkxLbTjRqt/fUNCTuOH2zgilTr67AFiewPzXEqB+oRYyRV
	UoEuisk/b/5gkZswDoL/YpNRAy/IXvqIGpDCuN4o98zQLFbxV3odC/QUVUtXq3jw==
X-Received: by 2002:a17:902:d589:b0:2ca:bf8e:3632 with SMTP id d9443c01a7336-2cd33d0a92bmr1272385ad.6.1783563893708;
        Wed, 08 Jul 2026 19:24:53 -0700 (PDT)
Received: from google.com (98.144.168.34.bc.googleusercontent.com. [34.168.144.98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a55a4727bsm346034a91.9.2026.07.08.19.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 19:24:53 -0700 (PDT)
Date: Wed, 8 Jul 2026 19:24:49 -0700
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: SCSI EH wakeup deadlock from deferred_qc
Message-ID: <ak8GcZ2k0AIkpMCe@google.com>
References: <20260708193644.671852-1-ipylypiv@google.com>
 <4a1b8987-7c76-41e2-baf9-6c176950593b@kernel.org>
 <26dbfbdd-4f9d-4a5f-8f61-a3bb7c457f50@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="L5JkSjuxSh2ERa2O"
Content-Disposition: inline
In-Reply-To: <26dbfbdd-4f9d-4a5f-8f61-a3bb7c457f50@kernel.org>


--L5JkSjuxSh2ERa2O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 09, 2026 at 10:01:11AM +0900, Damien Le Moal wrote:
> On 7/9/26 08:44, Damien Le Moal wrote:
> > On 7/9/26 04:36, Igor Pylypiv wrote:
> >> Hi Damien,
> >>
> >> I've stumbled upon an issue where SCSI EH didn't run upon command timeout
> >> but ran ~10 or so seconds later. It seems like a recent regression from
> >> the introduction of deffered_qc.
> >>
> >> When an active command times out while a non-NCQ command is waiting in
> >> deferred_qc, SCSI EH fails to wake up. Recovery stalls until the deferred
> >> command's own timer expires.
> >>
> >> When an NCQ command times out, scsi_timeout() calls scsi_eh_scmd_add(),
> >> incrementing shost->host_failed (1). However, when scsi_eh_wakeup() checks
> >> whether to wake the EH thread, scsi_host_busy(shost) counts 2 active
> >> commands (1 timed-out + 1 in deferred_qc).
> >>
> >> Because busy (2) != host_failed (1), scsi_eh_wakeup() refuses to wake
> >> the EH thread, deadlocking error recovery until the deferred command
> >> times out on its own.
> > 
> > Igor,
> > 
> > Can you try the attached diff ?
> > I will test on my end, but I need to hack something to trigger a timeout :)
> 
> Hacking libahci to trigger a timeout for a particular LBA read, I tested the
> attached v2 and I see the deferred QC running right after the read command
> timeout. So this looks like a good fix to me. Can you test please ?

Thank you for coming up with a fix so quickly, Damien!
The fix works for the issue I'm seeing!

Note: I tested on a 6.18 based kernel with your changes ported to libsas
to fix the issue for the pm80xx driver. Attached libsas diff for reference.

Thank you!
Igor

> 
> -- 
> Damien Le Moal
> Western Digital Research

> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 5868526301a2..5221d7004c0e 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1685,7 +1685,8 @@ void ata_scsi_deferred_qc_work(struct work_struct *work)
>  	spin_unlock_irqrestore(ap->lock, flags);
>  }
>  
> -void ata_scsi_requeue_deferred_qc(struct ata_port *ap)
> +static void ata_scsi_do_requeue_deferred_qc(struct ata_port *ap,
> +					    struct scsi_cmnd *timed_out_scmd)
>  {
>  	struct ata_link *link;
>  
> @@ -1698,15 +1699,27 @@ void ata_scsi_requeue_deferred_qc(struct ata_port *ap)
>  	 */
>  	ata_for_each_link(link, ap, PMP_FIRST) {
>  		struct ata_queued_cmd *qc = link->deferred_qc;
> +		u32 host_byte;
>  
> -		if (qc) {
> -			link->deferred_qc = NULL;
> -			cancel_work(&link->deferred_qc_work);
> -			ata_scsi_qc_done(qc, true, DID_REQUEUE << 16);
> -		}
> +		if (!qc)
> +			continue;
> +
> +		link->deferred_qc = NULL;
> +		cancel_work(&link->deferred_qc_work);
> +
> +		if (qc->scsicmd == timed_out_scmd)
> +			host_byte = DID_TIME_OUT;
> +		else
> +			host_byte = DID_REQUEUE;
> +		ata_scsi_qc_done(qc, true, host_byte << 16);
>  	}
>  }
>  
> +void ata_scsi_requeue_deferred_qc(struct ata_port *ap)
> +{
> +	ata_scsi_do_requeue_deferred_qc(ap, NULL);
> +}
> +
>  static void ata_scsi_schedule_deferred_qc(struct ata_link *link)
>  {
>  	struct ata_queued_cmd *qc = link->deferred_qc;
> @@ -1730,6 +1743,28 @@ static void ata_scsi_schedule_deferred_qc(struct ata_link *link)
>  		queue_work(system_highpri_wq, &link->deferred_qc_work);
>  }
>  
> +enum scsi_timeout_action ata_scsi_eh_timed_out(struct scsi_cmnd *scmd)
> +{
> +	struct ata_port *ap = ata_shost_to_port(scmd->device->host);
> +	unsigned long flags;
> +
> +	/*
> +	 * We had a timeout, either for an NCQ command or for one deferred
> +	 * queued command. Either way, we must release all deferred queued
> +	 * command so that scsi EH can trigger.
> +	 */
> +	spin_lock_irqsave(ap->lock, flags);
> +	ata_scsi_do_requeue_deferred_qc(ap, scmd);
> +	spin_unlock_irqrestore(ap->lock, flags);
> +
> +	/*
> +	 * Let scsi_timeout() know that it must continue with handling the
> +	 * timeout as we in fact did not do much here.
> +	 */
> +	return SCSI_EH_NOT_HANDLED;
> +}
> +EXPORT_SYMBOL_GPL(ata_scsi_eh_timed_out);
> +
>  static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
>  {
>  	struct ata_link *link = qc->dev->link;
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 96e626d6a7ca..327da43d7496 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -1153,6 +1153,7 @@ extern int ata_scsi_ioctl(struct scsi_device *dev, unsigned int cmd,
>  #endif
>  extern enum scsi_qc_status ata_scsi_queuecmd(struct Scsi_Host *h,
>  					     struct scsi_cmnd *cmd);
> +enum scsi_timeout_action ata_scsi_eh_timed_out(struct scsi_cmnd *cmd);
>  #if IS_REACHABLE(CONFIG_ATA)
>  bool ata_scsi_dma_need_drain(struct request *rq);
>  #else
> @@ -1464,6 +1465,7 @@ extern const struct attribute_group *ata_common_sdev_groups[];
>  	.ioctl			= ata_scsi_ioctl,		\
>  	ATA_SCSI_COMPAT_IOCTL					\
>  	.queuecommand		= ata_scsi_queuecmd,		\
> +	.eh_timed_out		= ata_scsi_eh_timed_out,	\
>  	.dma_need_drain		= ata_scsi_dma_need_drain,	\
>  	.this_id		= ATA_SHT_THIS_ID,		\
>  	.emulated		= ATA_SHT_EMULATED,		\


--L5JkSjuxSh2ERa2O
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename=6.18_libsas_ata_timeout.diff

diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index ffa5b49aaf08..b48dcc281042 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -500,6 +500,30 @@ int sas_eh_target_reset_handler(struct scsi_cmnd *cmd)
 }
 EXPORT_SYMBOL_GPL(sas_eh_target_reset_handler);
 
+enum scsi_timeout_action sas_eh_timed_out(struct scsi_cmnd *cmd)
+{
+	struct domain_device *dev;
+	struct ata_port *ap;
+	unsigned long flags;
+
+	if (!cmd)
+		return SCSI_EH_NOT_HANDLED;
+
+	dev = cmd_to_domain_dev(cmd);
+	if (!dev || !dev_is_sata(dev))
+		return SCSI_EH_NOT_HANDLED;
+
+	ap = dev->sata_dev.ap;
+	if (ap) {
+		spin_lock_irqsave(ap->lock, flags);
+		ata_scsi_do_requeue_deferred_qc(ap, cmd);
+		spin_unlock_irqrestore(ap->lock, flags);
+	}
+
+	return SCSI_EH_NOT_HANDLED;
+}
+EXPORT_SYMBOL_GPL(sas_eh_timed_out);
+
 /* Try to reset a device */
 static int try_to_reset_cmd_device(struct scsi_cmnd *cmd)
 {
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index c4f6a6a7f6bd..852de6a55448 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -712,6 +712,7 @@ void sas_task_abort(struct sas_task *);
 int sas_eh_abort_handler(struct scsi_cmnd *cmd);
 int sas_eh_device_reset_handler(struct scsi_cmnd *cmd);
 int sas_eh_target_reset_handler(struct scsi_cmnd *cmd);
+enum scsi_timeout_action sas_eh_timed_out(struct scsi_cmnd *cmd);
 
 extern void sas_target_destroy(struct scsi_target *);
 extern int sas_sdev_init(struct scsi_device *);
@@ -743,6 +744,7 @@ void sas_notify_phy_event(struct asd_sas_phy *phy, enum phy_event event,
 	.name				= DRV_NAME,			\
 	.proc_name			= DRV_NAME,			\
 	.queuecommand			= sas_queuecommand,		\
+	.eh_timed_out			= sas_eh_timed_out,		\
 	.dma_need_drain			= ata_scsi_dma_need_drain,	\
 	.target_alloc			= sas_target_alloc,		\
 	.change_queue_depth		= sas_change_queue_depth,	\

--L5JkSjuxSh2ERa2O--
