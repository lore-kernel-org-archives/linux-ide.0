Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE5F19CD1D;
	Tue, 31 Mar 2026 08:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774947131; cv=none; b=ZLHZplwK7gxAsqWPdLqW43BBpmxTujv9HbuRJjMciN5ufxdbYgSMSuMYAWXyHjfpG9UivFih9KtUG59dBAF3sKxDBTN6d9q8n8vJBrnlH42bMhlfFLwg+/z9sIDJlY6w2QQUfD5vBQWmuD+LedhzoJVsYw579UPDLPdtaZ6GaAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774947131; c=relaxed/simple;
	bh=xYphjV24OzYN0uWW3HnE5oc6HHM3KpcvOkbLMWDFNiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kMnFnwbW8e1aaxUci+Fo5Rt0cGidunzU4VH2B14LK5EsrYxtFbRovB7SkPitaQ/JAP0aVFVlIIdFm+Ya4sgxjgripea/roJvFWxiGyGQ881ko/Tzga1CK8lhrHfon8pNXHuYumNo1hyx6ab28vFrwxPwbqqMA27hMFXseJDMBtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKvqL7Xa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKvqL7Xa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0BFC19423;
	Tue, 31 Mar 2026 08:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774947131;
	bh=xYphjV24OzYN0uWW3HnE5oc6HHM3KpcvOkbLMWDFNiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VKvqL7XaeLgxQetBIasmJra4BPojNi3iOb9FJYmpozvh5rUq7dXcYBpys4oY8iw5a
	 57mfinus+6odyAfSyzq0Z5JfnxquZuvhu3EQv4EKVblDOD4Su92OkpwHBE7MnSVtU3
	 ncDCrPv+CnS6CVdP/ON4iJVDXdvXOvFZW1/zl/9FFgH4B1MqOta3FBHzJROGMptAJq
	 VJ6Wngh+pgRsz70QNqfXAmbtbymazYaHWNTYlSdyiaPWSr6wRa+oIPTvApvN7rBkGr
	 epRckwDGx8rsFxyt/Eh9bW2mkt7vgBHjyYT2PDQc2Pz49gFoJbPhRfzCgpTDYcd890
	 sC6uVYzb1l/Uw==
From: Niklas Cassel <cassel@kernel.org>
To: linux-ide@vger.kernel.org,
	Rosen Penev <rosenp@gmail.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCHv3] ata: libahci_platform: use flex array for platform PHYs
Date: Tue, 31 Mar 2026 10:52:06 +0200
Message-ID: <177494701275.1772503.6566506022926347086.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330203737.3995-1-rosenp@gmail.com>
References: <20260330203737.3995-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=646; i=cassel@kernel.org; h=from:subject:message-id; bh=xYphjV24OzYN0uWW3HnE5oc6HHM3KpcvOkbLMWDFNiM=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJPd5uruNw5Fdr3UvNu3o7YGlb9/Nef7Ofu3+L6Ui+08 dAEDqGajlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAExk/UdGhsnSl85ME9soLt2y dEF0/o1XXbp6rEJH1OMlv+0+2M2Seozhn+mOy5wPoo/smfrppZ7bqRU2M6e0Z178Ka1ouZpjl47 vTUYA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

On Mon, 30 Mar 2026 13:37:37 -0700, Rosen Penev wrote:
> Modify struct ahci_host_priv to use a flexible array member for an adapter port
> PHYs and use struct_size to combine the allocation of this array together with
> the adapter private data structure. __counted_by() annotation is added for the
> phys field to support runtime analysis.
> 
> 

Commit log was wrapped at 80 lines, I re-wrapped the commit log to 75 lines
while applying.


Applied to libata/linux.git (for-7.1), thanks!

[1/1] ata: libahci_platform: use flex array for platform PHYs
      https://git.kernel.org/libata/linux/c/d5d28615

Kind regards,
Niklas
