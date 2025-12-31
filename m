Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CD2314D10
	for <linux-ide@vger.kernel.org>; Wed, 31 Dec 2025 10:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767175493; cv=none; b=T7DDpYp69hfh3qnrc2ork8D0blAzWVYCjtB+TvRy1d/M+Ev9zpKhukeuglk06FcpVOdsz1u04yoAiQEl19aaAotPvTT4iPCuPDdcaLZwkAvpaUbU562Bhyug/djFJrirjyEdk+1zMDRJgKk3JYRTxxYHxqmsaW7xIyh3S/IrvPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767175493; c=relaxed/simple;
	bh=YHp+AOz9zCxe2GaMVLhVjSMhTnfCJvQ1l7CWj0J15PI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GC1hUHHZKVHlOii9ndR2gS499XEZZ2U/Lw/mSFAv3VvJ3fmcEEffdn5pMhKdZJDeIWKztaPZ03AonS4lKj7IypWnB1/aq/hnGFaZjYVyCU91TvMSA9p9/2LxFfWXgev/fMNicA72XZhTVloFkSAklPLY91Y8fH/B5JoIk0wzbUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zqo1N4pL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zqo1N4pL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD130C113D0;
	Wed, 31 Dec 2025 10:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767175493;
	bh=YHp+AOz9zCxe2GaMVLhVjSMhTnfCJvQ1l7CWj0J15PI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zqo1N4pLktUieFQTD88feLKPShiWPaxKx7Y5y5PoMb1JMVBKXXwV0KkpdVXMfY/eU
	 LQQ9qyflh5U45St1Extu5uohXbETLxidloTUM2iD8gL+LJ8vUxmHE/2xWeWKRXxITu
	 4xYpA2s6/6yilqkPZs9n4cuigWvQw5QuV//Jfh+/NHS580sIU8mKh3pIqCR556z/wk
	 m+fMkHKUxehU8CykKa2njx9iJtsOHqY65m63ZhlUrjIPQg5hsexmuKxlY2ST6001Ie
	 sXcyK6F+szUliWQtYXhnmzqarulqbDmNuDhxFbHHbT4GRr2+oFvRDoI+tlzxXoXsca
	 ovIwdd4dRsPGw==
Date: Wed, 31 Dec 2025 11:04:49 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>,
	Xingui Yang <yangxingui@huawei.com>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v3 0/2] Prevent non-NCQ command starvation
Message-ID: <aVT1QdEZq09kAjS-@ryzen>
References: <20251220002140.148854-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251220002140.148854-1-dlemoal@kernel.org>

On Sat, Dec 20, 2025 at 09:21:38AM +0900, Damien Le Moal wrote:
> This small patch series addresses potential command starvation issues
> with non-NCQ passthrough commands issued to a device accessed through

Here and everywhere else:
s/non-NCQ passthrough commands/non-NCQ commands/

The problem is really not related to passthrough commands,
but rather the mix between NCQ and non-NCQ commands.

E.g. you can perform a ioctl with the REQ_OP_DISCARD command,
for most ATA devices this is a SCSI WRITE SAME 16 CMD, which gets
translated to either a NCQ or non-NCQ command depending on if the
device supports NCQ encapsulated Data Set Management (DSM) commands,
and specifically if the device has the QUEUED DATA SET MANAGEMENT
SUPPORTS TRIM bit set or not, which is not a given.

TL;DR: the starvation problem is not directly tied to non-NCQ
passthrough commands, but any command, even commands that goes via
the block layer, that happens to be translated to a non-NCQ command.


Kind regards,
Niklas
