Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5271C20ED
	for <linux-ide@vger.kernel.org>; Thu, 10 Apr 2025 17:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744304437; cv=none; b=XedSFQ2dF8amJPWezaspCVB5AIJJt7DbBzcj7j8FEBSRn44II1w8LQaAKgfLIfTwRtKedOgP9RLLk4RahoHEdyHsL0hNSdiRgeiB4Jt9vDFvGKgsNiUYJ9tm/kf78KXxWLzOvFYcxMtQKeoOYJqhvGwuVAhzMuXappFVI69kvHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744304437; c=relaxed/simple;
	bh=lcmdf69vPaxpTIC0zUkKM850yMQ8D1bGyxRtCZ6N1oI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lS4ql851PJAuBIVnf7HwpOJ97c56RkUfzeCxZqJl9Sx/sFwg+q25p6u4Rc0rvwLu0JplTUDiHa5joSrGzkUzXrRuz8Lsk4nfS2VcxnzOATiPqGEpjv/lSsip3pfCFyIWYGzs3Ac3j3Y0kwluv+Cpib8q2z5tuDV0BdDxUyUvgE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fGQt7oWy; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fGQt7oWy"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2263428c8baso5355ad.1
        for <linux-ide@vger.kernel.org>; Thu, 10 Apr 2025 10:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744304435; x=1744909235; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dOGF+gRWyx5wAnMgxBqfVOy8Org8lXsK8c4GsITgYp0=;
        b=fGQt7oWyaR7JPi3Zp5AnqAnzJJ48DBUyDivhuBMt0MZNB4Ipa5nuFJWaTmwG6/y4lJ
         +uRjmouHK82ssZHGOPgC2OxpRV8qBy57PBUOo2O1EoUjN3yMEFJMrO5vtQl8OX8Xucdf
         7NrXZ/PSyYKhFE1cxIBahrevdoRefDRwryLaDXU2IB07KNemfjRnefGIgWY6b7heLhYd
         3/fD+wNH+4YaL9ulhAjH65csGY1SvzeRSkvOOnqkZdQVIAELr6A9LgcM9xmsxhVCWnjP
         brAk+F8ifyMYxPyFmCmNnA1loN1ODMOl4zb7ss5Fq8TEk+mPdduutqcEzohcOEbo8IZH
         wUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744304435; x=1744909235;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dOGF+gRWyx5wAnMgxBqfVOy8Org8lXsK8c4GsITgYp0=;
        b=hQWenZMLn1F+ygdCfyGgsuK6v5nRIAE27bMPxc4+/89u/KsKp995XWC255DDm/ShdH
         Pms73ALvIviDfIUMX9oxhvkVxixVVzK0kHNbUuS3voiKr/1SUPauCkD5xiiwRpVkSmLX
         f+WLEtlxmKAWCfhX/W6L1/1Q/KSqfa6ptw9d3dp+aBoT7gyFeCyoUDO+STuTwZZ+FmK/
         BI+IWUkm1ZU2TskGQ6iifWwMnr0URygan+nqesHIyP3/pkIxf/4CODXcS76/nsjPZdk5
         zgKSQxFvRrXRsdOIW7DRi6/uk6BGWWOcasQlpZTzSSIr39NkoJtT1YW+LNv611CLwzbD
         eD4w==
X-Forwarded-Encrypted: i=1; AJvYcCW1VhiRZzGdHfven9aL9tlTyaWnEmym9e7kFaj6bhVM/1rMO2sFhn/PY4TKP//ZKABsNU6gTnlq5Hs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi2Se3m8OOMiOnfz8Ha4eKlcqIjnNXFrb0fvZYDhXHfSfcZik1
	+HSdyDcU/HbP+6GlmJFa1lI+vhR0Gz/txG1dxs/JW7lFItRiHrPBx98H39tZ0PYRJV/P6AwMrBi
	/mw==
X-Gm-Gg: ASbGncu67WzSBpeEAOsXZhKPMipWuqmaepVtTZ75iDw1FNcyQ2HHMsTnidhJT/1S9Jz
	S62saLuRfljUttKl9iCN5HHnuFPINdAdJ6H8HuJPeHOUxsJo3rq4n4Y9Gi3xVlfGwnmBYBtdVVw
	/2ol+0LC1/dl8s4TTdB1Zao0XV4mHyRtpPCBF5b5IpJDlMLx0MJtEs4Abo43mQJ1CQKusVy87ru
	Fx8NGpkmGP0EBUN+cC5vnik6Z7z+XAB0H/kHsRj7Ox8At9D9l8b0sutWyjdRFMzshinqc9CXH9C
	egTTDBdM5yfNZ3rRgt5XQlchf3EjSj9x30QoV05uUYhaUyWcm5jA4hykU+SHtFA06pXPdympTus
	I
X-Google-Smtp-Source: AGHT+IF9X8+QD620PqFn9Nm1RRLLPD0xvJqg6YbFjfVTE6khtgGt2/i+jGQ4x4Y7NPd5YurVM5u4jA==
X-Received: by 2002:a17:903:2c6:b0:216:2839:145 with SMTP id d9443c01a7336-22bde3a749emr3206305ad.1.1744304434703;
        Thu, 10 Apr 2025 10:00:34 -0700 (PDT)
Received: from google.com (24.21.230.35.bc.googleusercontent.com. [35.230.21.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd10c41fsm4365357a91.8.2025.04.10.10.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 10:00:33 -0700 (PDT)
Date: Thu, 10 Apr 2025 10:00:29 -0700
From: Igor Pylypiv <ipylypiv@google.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH v2] ata: libata-sata: Use LBA from sense data descriptor
Message-ID: <Z_f5Lf48v6VNbvpB@google.com>
References: <20250409084546.121694-2-cassel@kernel.org>
 <Z_aul100eqb2-naM@google.com>
 <Z_fBaVZkcD9AtTaR@ryzen>
 <Z_fP7RKf5AbybyXB@ryzen>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z_fP7RKf5AbybyXB@ryzen>

On Thu, Apr 10, 2025 at 04:04:29PM +0200, Niklas Cassel wrote:
> On Thu, Apr 10, 2025 at 03:02:33PM +0200, Niklas Cassel wrote:
> > 
> > I guess now when we do have access to the information, the most consistent
> > thing would be to fill all field we can in qc->result_tf... but, to do this
> > for every IO might slow things down.
> > 
> > So is there perhaps some logic to only filling LBA (in addition to STATUS
> > and ERROR, which are filled for all NCQ commands), since that is the only
> > field that can change, as per the specs.
> 
> Looking at this more closely:
> https://github.com/torvalds/linux/blob/v6.15-rc1/include/linux/libata.h#L574-L577
> 
> FEATURE is a union with ERROR, so we cannot save it in qc->result_tf.
> 
> COMMAND is a union with STATUS, so we cannot save it in qc->result_tf.
> 
> 
> The sense data descriptor does not provide AUXILIARY, nor DEVICE,
> so we cannot save these.
> 

Successful Sense Data descriptor provides AUXILIARY field as well:

ACS-6 (revision 10)

        Table 339 — Successful Sense Data descriptor format
 +--------+------+-----------------------------------------------------+
 | Offset | Type | Description                                         |
 +--------+------+-----------------------------------------------------+
 | 0      | Byte | SENSE KEY field (see 9.29.3.2)                      |
 | 1      | Byte | ADDITIONAL SENSE CODE field (see 9.29.3.2)          |
 | 2      | Byte | ADDITIONAL SENSE CODE QUALIFIER field (see 9.29.3.2)|
 | 3      | Byte | COMMAND field (see 9.29.3.3)                        |
 | 4      | Byte | FEATURE field (7:0) (see 9.29.3.3)                  |
 | 5      | Byte | FEATURE field (15:8) (see 9.29.3.3)                 |
 | 6      | Byte | COUNT field (7:0) (see 9.29.3.3)                    |
 | 7      | Byte | COUNT field (15:8) (see 9.29.3.3)                   |
 | 8      | Byte | LBA field (7:0) (see 9.29.3.4)                      |
 | 9      | Byte | LBA field (15:8) (see 9.29.3.4)                     |
 | 10     | Byte | LBA field (23:16) (see 9.29.3.4)                    |
 | 11     | Byte | LBA field (31:24) (see 9.29.3.4)                    |
 | 12     | Byte | LBA field (39:32) (see 9.29.3.4)                    |
 | 13     | Byte | LBA field (47:40) (see 9.29.3.4)                    |
 | 14     | Byte | INFORMATION field (7:0) (see 9.29.3.5)              |
 | 15     | Byte | INFORMATION field (15:8) (see 9.29.3.5)             |
 | 16     | Byte | AUXILIARY field (7:0) (see 9.29.3.6)                |
 | 17     | Byte | AUXILIARY field (15:8) (see 9.29.3.6)               |
 | 18     | Byte | AUXILIARY field (23:16) (see 9.29.3.6)              |
 | 19     | Byte | AUXILIARY field (31:24) (see 9.29.3.6)              |
 | 20     | Byte | ICC field (7:0) (see 9.29.3.6)                      |
 | 21..23 | Bytes| Reserved                                            |
 +--------+------+-----------------------------------------------------+  

The data in AUXILIARY and ICC is only valid when the AUXILIARY AND ICC FIELDS
VALID bit is set. Similarly to other fields, AUXILIARY contains a copy of
command inputs.

Thanks,
Igor

> 
> I will send a v3 that does populate COUNT (7:0) and COUNT (15:8),
> since it is only so few fields that we do have, we might as well
> populate them properly.
> 
> 
> Kind regards,
> Niklas
