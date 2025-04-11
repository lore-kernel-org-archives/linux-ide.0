Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0B51EDA05
	for <linux-ide@vger.kernel.org>; Fri, 11 Apr 2025 06:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744353328; cv=none; b=uJFykhxZeHmAZlDMSPxCmyD22xGMbUqxCkg+RzHduX82CLCwYoC56Lfebdtl7gVWOIYH9AitDzGaU+D5ONYlkRmRHkM856B4QBMcs+IRP/oQOvUf3VK/WVMJPZoEktuEx0yN34sU2mzU6+bSWdbEE6IWTJ3irTOq5LiuZpK20HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744353328; c=relaxed/simple;
	bh=ULk5eaBpCJSH2Nygt5tGZNsFyRvcUqNZOsrP1YEFITI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjJLH7WSQ2NKr0BTjybuZIrmOtEd9QJUizWtCr5reMwyH65oRok9BqoU7fM/LZM4vZvODUWsrrcdDztpJzUGQoaMZf4lxe3le2TRFDMGjU8I7NM0UfpbWpzqsNornC2Ee6iKIatCnidgZl72tNEh6T///Di7xFU1l4Vy9qcT8Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igcw3JIu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igcw3JIu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7390C4CEE2;
	Fri, 11 Apr 2025 06:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744353327;
	bh=ULk5eaBpCJSH2Nygt5tGZNsFyRvcUqNZOsrP1YEFITI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=igcw3JIupCtLVVgZ+RPr65L6vGuoZh7UlqiUza0DA5oFUKzOioOU0UblINx1RLyUS
	 fma9icG4bSii29XMp4JcV7GkCyLgHGb0bT9hci8zoF7aT+IWe8f2sdbiabrYFfmnWq
	 v1HU85bKbbK/pQCGD9FNSkJlA4D74wzKj8zyUNi1DvrlWZamTO/5DMimoUyGA2jlOd
	 sdwPJb9K2JefklsrRr7xNX+Ufq5mDL/yfVEvmhP2LXZs1GyFD0/JgiwBuN1RSX6q1P
	 FkrhPDE2Hw6d7yFyRmlFIsIbWHrpPWDzmiUaHPOnKBTJURM5W4RfPj/vbgQFeX+6k7
	 HJHS9fSTHVYnA==
Date: Fri, 11 Apr 2025 08:35:24 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH v2] ata: libata-sata: Use LBA from sense data descriptor
Message-ID: <Z_i4LNxRNQNk4p3_@ryzen>
References: <20250409084546.121694-2-cassel@kernel.org>
 <Z_aul100eqb2-naM@google.com>
 <Z_fBaVZkcD9AtTaR@ryzen>
 <Z_fP7RKf5AbybyXB@ryzen>
 <Z_f5Lf48v6VNbvpB@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z_f5Lf48v6VNbvpB@google.com>

On Thu, Apr 10, 2025 at 10:00:29AM -0700, Igor Pylypiv wrote:
> On Thu, Apr 10, 2025 at 04:04:29PM +0200, Niklas Cassel wrote:
> > On Thu, Apr 10, 2025 at 03:02:33PM +0200, Niklas Cassel wrote:
> > > 
> > > I guess now when we do have access to the information, the most consistent
> > > thing would be to fill all field we can in qc->result_tf... but, to do this
> > > for every IO might slow things down.
> > > 
> > > So is there perhaps some logic to only filling LBA (in addition to STATUS
> > > and ERROR, which are filled for all NCQ commands), since that is the only
> > > field that can change, as per the specs.
> > 
> > Looking at this more closely:
> > https://github.com/torvalds/linux/blob/v6.15-rc1/include/linux/libata.h#L574-L577
> > 
> > FEATURE is a union with ERROR, so we cannot save it in qc->result_tf.
> > 
> > COMMAND is a union with STATUS, so we cannot save it in qc->result_tf.
> > 
> > 
> > The sense data descriptor does not provide AUXILIARY, nor DEVICE,
> > so we cannot save these.
> > 
> 
> Successful Sense Data descriptor provides AUXILIARY field as well:
> 
> ACS-6 (revision 10)
> 
>         Table 339 — Successful Sense Data descriptor format
>  +--------+------+-----------------------------------------------------+
>  | Offset | Type | Description                                         |
>  +--------+------+-----------------------------------------------------+
>  | 0      | Byte | SENSE KEY field (see 9.29.3.2)                      |
>  | 1      | Byte | ADDITIONAL SENSE CODE field (see 9.29.3.2)          |
>  | 2      | Byte | ADDITIONAL SENSE CODE QUALIFIER field (see 9.29.3.2)|
>  | 3      | Byte | COMMAND field (see 9.29.3.3)                        |
>  | 4      | Byte | FEATURE field (7:0) (see 9.29.3.3)                  |
>  | 5      | Byte | FEATURE field (15:8) (see 9.29.3.3)                 |
>  | 6      | Byte | COUNT field (7:0) (see 9.29.3.3)                    |
>  | 7      | Byte | COUNT field (15:8) (see 9.29.3.3)                   |
>  | 8      | Byte | LBA field (7:0) (see 9.29.3.4)                      |
>  | 9      | Byte | LBA field (15:8) (see 9.29.3.4)                     |
>  | 10     | Byte | LBA field (23:16) (see 9.29.3.4)                    |
>  | 11     | Byte | LBA field (31:24) (see 9.29.3.4)                    |
>  | 12     | Byte | LBA field (39:32) (see 9.29.3.4)                    |
>  | 13     | Byte | LBA field (47:40) (see 9.29.3.4)                    |
>  | 14     | Byte | INFORMATION field (7:0) (see 9.29.3.5)              |
>  | 15     | Byte | INFORMATION field (15:8) (see 9.29.3.5)             |
>  | 16     | Byte | AUXILIARY field (7:0) (see 9.29.3.6)                |
>  | 17     | Byte | AUXILIARY field (15:8) (see 9.29.3.6)               |
>  | 18     | Byte | AUXILIARY field (23:16) (see 9.29.3.6)              |
>  | 19     | Byte | AUXILIARY field (31:24) (see 9.29.3.6)              |
>  | 20     | Byte | ICC field (7:0) (see 9.29.3.6)                      |
>  | 21..23 | Bytes| Reserved                                            |
>  +--------+------+-----------------------------------------------------+  
> 
> The data in AUXILIARY and ICC is only valid when the AUXILIARY AND ICC FIELDS
> VALID bit is set. Similarly to other fields, AUXILIARY contains a copy of
> command inputs.

I was working on my laptop, and was not looking at the latest ACS-6 draft.
ACS-6 r2 has bytes 16 to 13 marked as Reserved.

But indeed, in the latest draft we do also have the AUX field, thank you
for noticing!


Kind regards,
Niklas
