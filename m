Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA68B195B0E;
	Mon, 17 Jun 2024 12:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718627841; cv=none; b=oIlS0qPBFV3aeMMXgJmgwI7SwnFqyJKQnFnnAXpiUGtoB+/dPxHll1RHe4xdCP4wEAJkoxdVXBnVaUPWq+QPlQAXBe/OPCU5khiKoq5+xHA1kfZvsM/dlLdDxaxWBm6XVphVekOPDM72TCoiSZgU6vtUCHKB0UkoKjQ3TrH5zsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718627841; c=relaxed/simple;
	bh=xMfBhzcDJOLu5wO0qEd3LkmaM4o8pnZqd6BFdNEHUKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqC/vNm/2pBboAjh6ugpcZtiCddiA40U36vypQZJghnO5+HocaY8rHODceyGpKEvyRA5OoPs4szSxhP1MXSbu1hiv2PDndpkJgMso61KXR9Sfisnenb4cFKaaUQTm+XJfJv6nEqWT09pv4Njp+oqrUeiJ3XH634qrHagC5sXBps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFl9gyyx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFl9gyyx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A308C2BD10;
	Mon, 17 Jun 2024 12:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718627841;
	bh=xMfBhzcDJOLu5wO0qEd3LkmaM4o8pnZqd6BFdNEHUKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mFl9gyyx53yQCt9QBaeceeR/DPvFjxbd2NOA3Zsa6wRwrSwm9LM0+wFFmiM16jejM
	 IR6iNx6y/5B5AKJ9eve0zyYr26t2s54U0KO9r/1rw7IVZYBsM1VZt0XMoAIPf+S8Bt
	 X/OeJ7vhQzyBEMDgZACxbaj6JEdzT7oQLWFnUulK66qeDth+oNOj7XOLo23PvKH6UT
	 G6nqDuPXlXUpt7Dd7m+kY4+zTXFAS3f02SmvM5DjiuAJuNjuSYwr4LqUjLShqZ2SxJ
	 wVzbWHMHefN+6B0P+xyQms8WdVO5QMPgC8dPMKGpEqng3oMZmjt/RoaBfVH68j0B/8
	 bw6GjkriEzy5A==
Date: Mon, 17 Jun 2024 14:37:17 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] ata: libata-scsi: Generate ATA PT sense data when
 ATA ERR/DF are set
Message-ID: <ZnAt_YSCX_aebHEn@ryzen.lan>
References: <20240614191835.3056153-1-ipylypiv@google.com>
 <20240614191835.3056153-3-ipylypiv@google.com>
 <ZnAeFbdt02zge2my@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnAeFbdt02zge2my@ryzen.lan>

On Mon, Jun 17, 2024 at 01:29:25PM +0200, Niklas Cassel wrote:
> 
> However, if there is any bits set in cmd->result,
> scsi_io_completion_nz_result() will be called:
> https://github.com/torvalds/linux/blob/v6.10-rc4/drivers/scsi/scsi_lib.c#L1052-L1053

If forgot to say that, if ATA_ERR and Sense Data Available bit is set:
ata_eh_analyze_tf() will call scsi_check_sense() which will set the
SCSI ML bit for many ASC/ASCQ codes.


If Sense Data Available bit is set, but ATA_ERR is not set:
-For non-NCQ commands, ata_eh_read_sense_success_non_ncq() will call
scsi_check_sense() which will set the SCSI ML bit for many ASC/ASCQ codes.

-For NCQ commands, ata_eh_read_sense_success_ncq_log() will call
scsi_check_sense() which will set the SCSI ML bit for many ASC/ASCQ codes.



The SCSI ML bit is stored in cmd->result, so if scsi_check_sense() did
set the SCSI ML bit, cmd->result will be non-zero, which means that once
scsi_io_completion() is called, it will call scsi_io_completion_nz_result().


Kind regards,
Niklas
