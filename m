Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21157A32;
	Tue,  3 Dec 2024 04:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733199419; cv=none; b=UnFX0JUnsO2kaXdJwmuLiMiQ0GR3+a4Iam7Lo7XAjNQCvDWS2rm0WdAgh5VmjnOc+a17moCPiWY3B9l7kDcoCmCUrNevnX0iLdRFuZ6W2vGMLoFTd+/QVtbrBSFS1L0mwAVNxwLx0lYn3hZaZkmg6SItg7ekQxmiVgG8qNnMF38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733199419; c=relaxed/simple;
	bh=IQKKHg9p6hfrWUJuYK3ByRKReOUJg8oApYZ2F6MbCGg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lGrK9V7VzvzmZ8mupyrKT8yTI1WeIDtc4MjU14QEJ9CSHtgYv98ZVw4kAoFV36Kj8oVbDa9Mn6O47OdtuR5p9gZePHdyg0Hkz1+5TxqS64mFZa9Z4hzuHGdo1RerTxGyrV/HWWPcDLJ0wzRDGAaSuM9+TujkGd8Q1fYK+oa90gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqGJIwHq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqGJIwHq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66103C4CECF;
	Tue,  3 Dec 2024 04:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733199418;
	bh=IQKKHg9p6hfrWUJuYK3ByRKReOUJg8oApYZ2F6MbCGg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VqGJIwHqUzMiB0aR5XfxEQprG0ML6BmHHGOQpoy2DqSJe6zhXV4yVbTS0giEnqxWz
	 oaKtq99Qkm9TW0VFZ0jMbtLKGz/ACYXJGEqUCdFX1ErLtluNx3W6y0KJrWZ8zVreZZ
	 6ZDQ38CMTELnC6ONaFf8tL5tUq8jQdFFSYmuPoqcRvFRXunO33K5VUYdPPXY4dpaP/
	 VIJl7AxK86HXtK0aw1BuRGivRDdQ2BNBq7zYME1MhU8i/k8cPFQAP9y+4Wl0jMV4PQ
	 GA0taRqwb4wTuHt+COCwG1Sub806zlBZ5kl8l8hzO1PaXb6uPNKFtrErP1erVQfwK9
	 8JNsQzDx2uH/w==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 linux-ide@vger.kernel.org
In-Reply-To: <8bddfee7f6f0f90eeb6da7156e30ab3bd553deb1.1731704917.git.christophe.jaillet@wanadoo.fr>
References: <8bddfee7f6f0f90eeb6da7156e30ab3bd553deb1.1731704917.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] ata: Constify struct pci_device_id
Message-Id: <173319941712.503679.15596945650956791315.b4-ty@kernel.org>
Date: Tue, 03 Dec 2024 05:16:57 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Fri, 15 Nov 2024 22:08:55 +0100, Christophe JAILLET wrote:
> 'struct pci_device_id' is not modified in these drivers.
> 
> Constifying this structure moves some data to a read-only section, so
> increase overall security.
> 
> On a x86_64, with allmodconfig, as an example:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>    4245	   1454	      4	   5703	   1647	drivers/ata/ata_generic.o
> 
> [...]

Applied to libata/linux.git (for-6.14), thanks!

[1/1] ata: Constify struct pci_device_id
      https://git.kernel.org/libata/linux/c/9986ce65

Kind regards,
Niklas

