Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7253299A8C;
	Tue, 10 Jun 2025 12:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749558822; cv=none; b=K4+xYlYcFL2gKM5IjgnG18nz9K1QVDAUK9zfQvrKKOd6gfi2UExeUM2Td2brEvYiMaGfTn4a48hpKVMJSYz2dbjAO8sGOXjeuZZwWRlQkDTRydD4POZPDrOPgUf4p5RDBOduP2Fdsjc4wzCwKYoNYQvzr/ObPZAzHPnBrXe3C5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749558822; c=relaxed/simple;
	bh=z5wf/2Wt6sJmolssQJVbXfiaB3yA+Y6FQUeMotADxpw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XEM69odvJ14+AbuEjgHVuwE3lW3S1q05f0aVneZT32nXnjs85oZrZ0MbilUHe/27D1uCWXqziUDgGgtbV4rr2HkdZ3NDuhusDD+Pp2XA23tixa+/y5x+GkzlN24U7m4e4K5qdWqe6qlN1xFWj13NKv0wYGsf2DiWuVdlBALdqtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGxRGaVQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGxRGaVQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A32C4CEF1;
	Tue, 10 Jun 2025 12:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749558821;
	bh=z5wf/2Wt6sJmolssQJVbXfiaB3yA+Y6FQUeMotADxpw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gGxRGaVQPetq/DA84SLHE7nJpJdrIs7p4nkoTpvcMjV7nn0S2SIgXXdTDJlYK6/We
	 96VF+cCmppPk3BG+3ZwYfUKW08D2jBCIlkH6hXC8qUVylCARTtsdR4ZktCi+zbPJum
	 k7DT2M9e9pmOcomirunTVF0sqMtCPCGo+XlTOL37FKKAk82wlTtvqxiqy20CN1Fcdy
	 cxWWQa7oJ7y+UWgK/vecoXYPKFQ4DdgtTSh/FBdcKcp07k8s6epEk6ORBaa7jE9sS3
	 VeQsPSzfRKkA4D8C2QZg2LOdD3xJZwOYTRQ3MkzhTVa64/wIQAs/x6d1mIvHjgf39g
	 yf+3QKM9LLh5g==
From: Niklas Cassel <cassel@kernel.org>
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, 
 Johannes Berg <johannes@sipsolutions.net>
Cc: Damien Le Moal <dlemoal@kernel.org>, 
 Johannes Berg <johannes.berg@intel.com>, Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <20250606090110.15784-2-johannes@sipsolutions.net>
References: <20250606090110.15784-2-johannes@sipsolutions.net>
Subject: Re: [PATCH] ata: pata_cs5536: fix build on 32-bit UML
Message-Id: <174955882032.1439612.8694655458527101424.b4-ty@kernel.org>
Date: Tue, 10 Jun 2025 14:33:40 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Fri, 06 Jun 2025 11:01:11 +0200, Johannes Berg wrote:
> On 32-bit ARCH=um, CONFIG_X86_32 is still defined, so it
> doesn't indicate building on real X86 machines. There's
> no MSR on UML though, so add a check for CONFIG_X86.
> 
> 

Applied to libata/linux.git (for-6.16-fixes), thanks!

[1/1] ata: pata_cs5536: fix build on 32-bit UML
      https://git.kernel.org/libata/linux/c/fe5b391f

Kind regards,
Niklas

