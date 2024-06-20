Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94671A3BD1;
	Thu, 20 Jun 2024 13:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718889162; cv=none; b=hkiEp0wURbzTKSn6dikrmR1HBb8AoSN8FiMIjdBJpGrwFD2O8t2NO7+LXi6vKeTyQuWikzx5+nKjRm+sF9aWZqGb8xIXIkL9r45bF9gkPnMs6wD7L33DeseAoerWREOY/boJuwTQzVhWdTR0SZsYZwfa2e/W5XZS6r+rNXSeW6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718889162; c=relaxed/simple;
	bh=nUPARufmTQoPjwldcNieQ4fQOnd1XePKbFHeUmIqVKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJsNqRaYVbPilQPlK4aCAgVbxKnl3NyFRWydr3bcu3aPMK07CttuyhJMRS06bT6/rPXypoSjbVfYAnhRBX4nTBL1gRrxMLANAzWAMIiwwtTb0imHQgqjwdUZDZvf3sakfdsm90RN6/cZlP1I+EN+9hcvu0L7PRikw++3RKWT6WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVKpzJpo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVKpzJpo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9279AC2BD10;
	Thu, 20 Jun 2024 13:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718889162;
	bh=nUPARufmTQoPjwldcNieQ4fQOnd1XePKbFHeUmIqVKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uVKpzJpoy/6y9BsD8eZiJNXZktwqBMrKa4Na06PMerdu9+mPNdXU1JItUJTxpdibQ
	 CzSGuhr2OuBiPRm4srYI+X7QS3ihfJTlSrugqLG2D1dLSgJZDEmThKN99PGyu6XroD
	 Isr2FwsVugcNuxLcgZR53J44Vk3ylVXx6Xo32+1lCJTNkJh4ReDQBItPD9mOlZpPta
	 66bsF7/i0rZ9vzWwaLfRMitrpboX+HSBCyqmQxtObE3PW9XObUrzrivFzGyiMOoWrL
	 AfRBlBFGZKkZ0QZvpMIdqpGLfaIy0YJgVKaWH6eAiZUU53ocBXZWFfdgUd4KLwx3+t
	 fBDypr0fzkWIg==
Date: Thu, 20 Jun 2024 15:12:37 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] ata: libata-scsi: Generate ATA PT sense data when
 ATA ERR/DF are set
Message-ID: <ZnQqxTgSTDHCBDNJ@ryzen.lan>
References: <20240614191835.3056153-1-ipylypiv@google.com>
 <20240614191835.3056153-3-ipylypiv@google.com>
 <b87d51d8-5a89-480e-b229-7750c241aa6f@kernel.org>
 <ZnDfNLBwsG6zFJ4-@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnDfNLBwsG6zFJ4-@google.com>

On Tue, Jun 18, 2024 at 01:13:24AM +0000, Igor Pylypiv wrote:
> 
> Any failed ATA PASS-THROUGH command with CK_COND=1 has this issue. For example,
> Sending READ SECTOR(S) EXT via ATA PASS-THROUGH with CK_COND=1 to an lba
> that was previously corrupted by WRITE UNCORRECTABLE EXT is supposed to
> return "READ ERROR - LBA MARKED BAD BY APPLICATION CLIENT" but instead it
> returns generated "UNRECOVERED READ ERROR - AUTO REALLOCATE FAILED".

I assume that the drive generated correct sense data, but that
ata_gen_passthru_sense() overwrites/overwrote the sense data with
generated sense data based on taskfile registers?


Kind regards,
Niklas
