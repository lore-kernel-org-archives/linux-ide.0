Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CA814EC58
	for <linux-ide@vger.kernel.org>; Thu, 11 Apr 2024 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842215; cv=none; b=svWAMv0NWmWNzOueBoI6dcV6PLRSCalq3fP2bmuZI9WUVmMsGJ8djNAnAxx69QrbHolmR3penkK/oMel26wbWf1UPT1FmjG+eBpMC8SPZwV2Yp9nqOOFXig6fSuFcYwZcjY/pADJgZrih6ALytrf7qawmf7t9nSgIUWFsvgIHMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842215; c=relaxed/simple;
	bh=84ZlPVJ9GuWhaAAUpyL0a0GhYGA3HeUh0ZP/VRFIRjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=U9g4B7JNfg5fR49XEwMeNN78h1EvL1Ec3zqKVdr1eZtfZTXnqu5MHQRuW3om7KlA5IwtsQqA/+wUX06UVlPhQOnhWUwWrXaCUefcKNmkBwbgyFlnjip18iLEGnyfMFkiCPE1RB7bZ7RTnc2XWzZRjIVN58GPUicu01ny+oCbDBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a52223e004dso69268966b.2
        for <linux-ide@vger.kernel.org>; Thu, 11 Apr 2024 06:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712842211; x=1713447011; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AG7gXI0/dWYxV6NY+c7hOksU5O3hWdPCPHZeuwYXcc8=;
        b=JK/Dll39BHzn39KVMvOTjf2Mal/brRJYssuvo4yu6SlN7im8KCm9skxHhDq9b8lIuc
         1u7DJGqqu/bqPX+5jxoJtKaDLUqRBV2dFq7S4OTul2kmLNqPa8uOHSGKtdLZ2feZNUHl
         EfTTuH5RGn3uMQZeR4TTRv3WCE7FHcTEltSUnaLeUGobdFgNqhi5x1EGmm3tB/bYdMXf
         zK1okwyxsSfdDW8dkUo5+qzT+5ODwEwKJ2d/P0VmTpUk7E0IolfChW6Aytlf2GO/edgC
         Ij8xP0sueeD2X/4KMO/BmU+ncbV9f4qFVR77wl2XIDXrzVDPO2n0zvGK/1K5LvalPcIN
         jUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712842211; x=1713447011;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AG7gXI0/dWYxV6NY+c7hOksU5O3hWdPCPHZeuwYXcc8=;
        b=ANyQzPjl0Ij0h9Y5llJY5bASw19ksTt0jEOaFDQ9/qAEYczXunLd1Iw4Owsi3m3PkI
         t4QhuepBrVGiQs/KAbo7jWg54vDfbF6crKm8WE7X6iq35mwGtQyjq5gBtmNxlb3YgAg+
         iiPou5pL2kaHEbk9EmiXFaU1NWZsz5J+0nz4ID2b7Tj6W0IIaKPXvvx0g4qDqs79GdQ/
         w9v+T5AX5fMbZbWPWCkd4TzG4+QSzTCZAFJPdgQe8/9pmCgxeGLTsUOvMfeEd+9J5wzj
         DktIdmeCZbl/2Kskqi4Jwel9j660kOPGp9LYEt6aglodxXaXUaiK02t3oQXE4yi9lvZo
         DCQQ==
X-Gm-Message-State: AOJu0Yy7sE07s0OJzw+jYhavSvfzp+MeBCtpJ8w0KqshdCF8+wqQlIoQ
	I0qP7lnpwahfDQk7+XwHh9TBVKqZhZedNZq2NGgFCeG4nl36+9YAug4o5qqG4Fk=
X-Google-Smtp-Source: AGHT+IFSSWu3W17NWPDPyBWqEbbNhJ3G99Nv1HAf4zs5coZ3qGflezfGyEXbuPW8ZtEnxjr9UTQ80Q==
X-Received: by 2002:a17:906:b24a:b0:a52:129d:ca66 with SMTP id ce10-20020a170906b24a00b00a52129dca66mr2926975ejb.21.1712842211290;
        Thu, 11 Apr 2024 06:30:11 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id hd13-20020a170907968d00b00a5217964308sm750703ejc.218.2024.04.11.06.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 06:30:10 -0700 (PDT)
Date: Thu, 11 Apr 2024 16:30:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: dlemoal@kernel.org
Cc: linux-ide@vger.kernel.org
Subject: [bug report] scsi: sd: Fix TCG OPAL unlock on system resume
Message-ID: <1c19822c-5622-4073-bc91-16523bb14302@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Damien Le Moal,

Commit 0c76106cb975 ("scsi: sd: Fix TCG OPAL unlock on system
resume") from Mar 19, 2024 (linux-next), leads to the following
Smatch static checker warning:

	drivers/ata/libata-scsi.c:4774 ata_scsi_dev_rescan()
	error: double unlocked 'ap->lock' (orig line 4757)

drivers/ata/libata-scsi.c
    4726 void ata_scsi_dev_rescan(struct work_struct *work)
    4727 {
    4728         struct ata_port *ap =
    4729                 container_of(work, struct ata_port, scsi_rescan_task.work);
    4730         struct ata_link *link;
    4731         struct ata_device *dev;
    4732         unsigned long flags;
    4733         bool do_resume;
    4734         int ret = 0;
    4735 
    4736         mutex_lock(&ap->scsi_scan_mutex);
    4737         spin_lock_irqsave(ap->lock, flags);
    4738 
    4739         ata_for_each_link(link, ap, EDGE) {
    4740                 ata_for_each_dev(dev, link, ENABLED) {
    4741                         struct scsi_device *sdev = dev->sdev;
    4742 
    4743                         /*
    4744                          * If the port was suspended before this was scheduled,
    4745                          * bail out.
    4746                          */
    4747                         if (ap->pflags & ATA_PFLAG_SUSPENDED)
    4748                                 goto unlock;
    4749 
    4750                         if (!sdev)
    4751                                 continue;
    4752                         if (scsi_device_get(sdev))
    4753                                 continue;
    4754 
    4755                         do_resume = dev->flags & ATA_DFLAG_RESUMING;
    4756 
    4757                         spin_unlock_irqrestore(ap->lock, flags);
                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    4758                         if (do_resume) {
    4759                                 ret = scsi_resume_device(sdev);
    4760                                 if (ret == -EWOULDBLOCK)
    4761                                         goto unlock;
                                                 ^^^^^^^^^^^^

    4762                                 dev->flags &= ~ATA_DFLAG_RESUMING;
    4763                         }
    4764                         ret = scsi_rescan_device(sdev);
    4765                         scsi_device_put(sdev);
    4766                         spin_lock_irqsave(ap->lock, flags);
    4767 
    4768                         if (ret)
    4769                                 goto unlock;
    4770                 }
    4771         }
    4772 
    4773 unlock:
--> 4774         spin_unlock_irqrestore(ap->lock, flags);
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Double unlock

    4775         mutex_unlock(&ap->scsi_scan_mutex);
    4776 
    4777         /* Reschedule with a delay if scsi_rescan_device() returned an error */
    4778         if (ret)
    4779                 schedule_delayed_work(&ap->scsi_rescan_task,
    4780                                       msecs_to_jiffies(5));
    4781 }

regards,
dan carpenter
