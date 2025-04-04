Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12658145B25
	for <linux-ide@vger.kernel.org>; Fri,  4 Apr 2025 19:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743794304; cv=none; b=TYYdNvYlJDi88GGOS1fUU/0LUaJb3imJh60VNX895Qwe17gX4FLpH59pKM/ClWhn1CndVurH/44KHUcNCcX0oGKCNScjhHl4UFJYohkApwI/m8hmMhvjdMGtKTyNZkaJWI//OCQW8v1mxI7v8vlxb1r60bjzaQfih0sZXjlLy50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743794304; c=relaxed/simple;
	bh=yuLgbxQGvrOS2X08diIgybCCQx/nMdoQsHko7b9lT2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=od+BFJJ36ovTNTLNYwhLK2N0ruwTcGtM8N8wKDo18lHOogvaK3FFE5AHxcbmpIrswlWKUXVgPqsSKm8e49WciHYUXOdryF+CS+Ee1GtAie/Cij9aYHXJVGSD0RLZieCYQ2vJvpgN+ZE6VKflwmEiTKw3Iux7H5BJjG6VW/ui8SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tbT2Oa6V; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tbT2Oa6V"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2264c9d0295so32635ad.0
        for <linux-ide@vger.kernel.org>; Fri, 04 Apr 2025 12:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743794302; x=1744399102; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LSagy7uSrSThurXFGxgzOfcgNiZbdsnlLtFl9TRWcgQ=;
        b=tbT2Oa6Vf6xV0cI6e96lUHkk/57MUMi9tT5MQBiuHnwNua7zFHRRMFm41m1eis44u3
         n23bz8BASep5u1T9XDJog1eyb1dmFtDNg6ZX3DECfn/t8qbIyB+4o+6Fo3JvZQrwAOZL
         x3g2lUoYsZLPXFZwok5E55FUfFsHc15XPD+WZ9LuLMzbWlKR9xxHvbXEuFn4MN0iL6DS
         2XCbeIYwN3T+4l83A4jqzdXjnyQFgvG0LqKEhCN4MUUW6NClgcbu6bLNP/fB67xbmoTB
         pjpG1bBwI1Y8irysylpweGPa8i+XUIapbqogHMdIetoePSyIVgMMClKCnIFU7hXUYEYj
         qZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743794302; x=1744399102;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LSagy7uSrSThurXFGxgzOfcgNiZbdsnlLtFl9TRWcgQ=;
        b=f1Wgo4+yXZ7QD+AiRuyMAcOQdSpnoif3vz14+UVOlKCXimBHmeysj0U+er0vciQI1M
         AeCOOVh+KOSiB3t4TKFvzKHcm7KdRvlUC2133jsDx80biQkoO4r8CF9RF8znaay2V/uV
         cim2Ux8XZNARhosqowmnu/DibCw73L/CvIXZ6paGNL7T5EYLvgg6MHSGZDkTUVcjR0lb
         eSUmBz0cd2sqKSZYHcIF9mGXNzIeCOR/sio1PlCPjk2ry4Vedy3jCrnXGYGK6x/kN+6m
         adv/w4ZXeDA9W9kYTJvay1EG6iqHs4QB2ulZJzVaI5mCT5aS+YLfq+5vXGQdY3ofjDnX
         52WA==
X-Forwarded-Encrypted: i=1; AJvYcCWhhpdC1oCsaA5BMTX9BJ7bUGOFDc+xQmXOwr6DemJLHnJZpBgEj+SDmGlP/gghmK5FXCQlKUWP3Fo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwpoEvAcDEFGH0Ktv5JYlmPkm6f0DBRcNU+Q+SovncPfdsHf5l
	eHZ48Ad86wLA/JCePjcBt3D9LOLvFOCcb4DVM3Rkh9dHqpSlWYF3RzsPdMeWiQ==
X-Gm-Gg: ASbGncuiTP6DjUC0sPOv1Qtx3lEpPYipfmGwGLAuKUtcdqNKxUGgQV+0dEvkd3ecaMl
	KpHebOBL4ao+36ZjDUEznF7PH494vYqqpmyUzClSTufxOEJ+WCQnpDjODQmK9Z82d/vnldkfrSX
	mlJkYlfO3uUUBiBomjXf6CmXk9ufD9xdGcZ+0drArj1P5ssPZQTmHy5FIzXC8oMl+VLolWXuYQp
	psi8A48p16vN9z3Z2NwoVlfwDBC8Z726spvwVTTjWyjY9IInrUzZNF1pMM6JI/lFemQyPoYBcCV
	DzWRFiksY2ALQF0YnTXuRQdxFrBjeIl0MEKxsqk+F45pm8GKgmpmx4grlFRkIq6oFBfhFiIhnOb
	hjw3y
X-Google-Smtp-Source: AGHT+IEn9cGd3ZCBXhuYvQcOgN02mAky4Jb9syFIcmxF7RAopcTEIkPdqg9Mvvk7Bu9Hut8z4qsu0w==
X-Received: by 2002:a17:903:3c6f:b0:21f:3f5c:d24c with SMTP id d9443c01a7336-22a95dab1f8mr442165ad.0.1743794301968;
        Fri, 04 Apr 2025 12:18:21 -0700 (PDT)
Received: from google.com (24.21.230.35.bc.googleusercontent.com. [35.230.21.24])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc41a835sm3195120a12.70.2025.04.04.12.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 12:18:21 -0700 (PDT)
Date: Fri, 4 Apr 2025 12:18:16 -0700
From: Igor Pylypiv <ipylypiv@google.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ata: libata-scsi: Set INFORMATION sense data field
 consistently
Message-ID: <Z_AweMPLRJgBIBF3@google.com>
References: <20250403212924.306782-1-ipylypiv@google.com>
 <Z-_JExGDyO9pVTON@ryzen>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z-_JExGDyO9pVTON@ryzen>

On Fri, Apr 04, 2025 at 01:57:07PM +0200, Niklas Cassel wrote:
> Hello Igor,
> 
> 
> I'm missing the bigger picture here.
> 
> Are we violating the spec? If so, please reference a specific
> section in the specs.

Hi Niklas,

Thank you for the thorough review!

I'm using the SAT-6 (revision 2) spec:

11 Translation of ATA errors to SCSI errors
11.7 INFORMATION field

             Table 201 — Contents of the INFORMATION field
 +---------------------------+------------------------------------------+
 | ATA command               | INFORMATION field                        |
 +---------------------------+------------------------------------------+
 | FLUSH CACHE               |                                          |
 | FLUSH CACHE EXT           |                                          |
 | READ DMA                  |                                          |
 | READ DMA EXT              |                                          |
 | READ FPDMA QUEUED         |                                          |
 | READ SECTORS              |                                          |
 | READ SECTORS EXT          |                                          |
 | READ VERIFY SECTOR(S)     | ATA LBA field ᵃ                          |
 | READ VERIFY SECTOR(S) EXT |                                          |
 | WRITE DMA                 |                                          |
 | WRITE DMA EXT             |                                          |
 | WRITE DMA FUA EXT         |                                          |
 | WRITE FPDMA QUEUED        |                                          |
 | WRITE SECTOR(S)           |                                          |
 | WRITE SECTOR(S) EXT       |                                          |
 +---------------------------+------------------------------------------+
 | All others                | Unspecified                              |
 +---------------------------+------------------------------------------+
 | ᵃ From ATA error outputs (non-NCQ) or ATA NCQ Command Error log      |
 +----------------------------------------------------------------------+

> 
> From SPC-7:
> """
> The contents of the INFORMATION field are device type or command specific
> and are defined in a command standard. See 4.4.4 for device server
> requirements regarding how values are returned in the INFORMATION field.
> """
> 
> Looking at SBC-5, "4.18.1 Error reporting overview":
> 
> """
> If a command attempts to access or reference an invalid LBA, then the device
> server shall report the first invalid LBA (e.g., lowest numbered LBA) in the
> INFORMATION field of the sense data (see SPC-6). If a recovered read error is
> reported, then the device server shall report the last LBA (e.g., highest
> numbered LBA) on which a recovered read error occurred for the command in the
> INFORMATION field of the sense data.
> """
> 
> Since we are generating this, it makes me thing that perhaps we should not
> set the INFORMATION field unconditionally? I guess it makes sense for e.g.
> REQ_OP_READ/READ_OP_WRITE commands, but probably does not make sense for e.g.
> REQ_OP_FLUSH commands?
>

SAT-6 specifies that we should set ATA LBA for FLUSH CACHE [EXT] as well.
For "All others" commands (not explicitly listed in Table 201), the value
in the INFORMATION field is "Unspecified". I think it should be fine to
set ATA LBA for other commands as well. 

> 
> On Thu, Apr 03, 2025 at 02:29:24PM -0700, Igor Pylypiv wrote:
> > The INFORMATION field is not set when sense data is obtained using
> > ata_eh_request_sense(). Move the ata_scsi_set_sense_information() call
> > to ata_scsi_qc_complete() to consistently set the INFORMATION field
> > regardless of the way how the sense data is obtained.
> 
> As you know, we also have successful commands with sense data
> (CDL policy 0xD), see ata_eh_get_success_sense().
> 
> These commands will either fetch sense data using
> ata_eh_get_ncq_success_sense() or using ata_eh_get_non_ncq_success_sense()
> (the latter function will fetch sense data using ata_eh_request_sense()).
> 
> Regardless of the path taken, these commands will also end up in
> ata_scsi_qc_complete(), so perhaps it is not enough for your patch to
> modify ata_scsi_qc_complete() to simply set the INFORMATION field for
> commands with ATA_ERR bit set (is_error) ? Perhaps you should also
> consider commands with sense data (have_sense), but without is_error set?
>

SAT-6 "11.7 INFORMATION field" has a footnote for the "ATA LBA field" as
follows: "From ATA error outputs (non-NCQ) or ATA NCQ Command Error log".

I limited the change to commands with ATA_ERR bit set (is_error) because
the spec explicitly mentions errors and the whole section 11 is dedicated
to the translation of ATA errors. 

> 
> > 
> > This call should be limited to regular commands only, as the INFORMATION
> > field is populated with different data for ATA PASS-THROUGH commands.
> 
> I do agree that for ATA PASS-THROUGH commands with fixed format sense,
> the INFORMATION field is already defined by SAT.
> 
> However, what about ATA PASS-THROUGH commands with descriptor format sense?
> 
> ATA Status Return sense data descriptor, which is used by ATA PASS-THROUGH
> commands has descriptor type 09h.
> 
> Information sense data descriptor has descriptor type 00h.
> (See 4.4.2.2 Information sense data descriptor in SPC-7.)
> 
> Is it perhaps possible for a command to have both descriptors?
> 
> After reading SPC-7, "Table 30 – DESCRIPTOR TYPE field"
> 
> I would say that is appears that you usually just have one descriptor,
> so I would say let's continue only having the ATA Status Return sense
> data descriptor for ATA PASS-THOUGH commands.
>

Agree. ATA Status Return sense data descriptor for ATA PASS-THOUGH commands
already contains the ATA LBA in bytes [6..11] so it seems redundant to
also include the same in the Information sense data descriptor.   


Thank you,
Igor
 
> 
> Kind regards,
> Niklas
