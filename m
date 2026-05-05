Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198742264A9
	for <linux-ide@vger.kernel.org>; Tue,  5 May 2026 14:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777992591; cv=none; b=Nb3B+J346hIR7yUvzRK7+Zoxw6GOFaaWkALH243euR98tqRMR4BtVv0vdzRF2oelfkzcM3XsbeK3HXoooV7dHaAdghWvS329jEYMM18xcSPtqQdC2pkH9gTHh1vVgJ0pNRP6tDDgbHqjrqhFMENOUQvugL5uj0wCWkNhFJPmuwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777992591; c=relaxed/simple;
	bh=inmvLJcpsZfCXoffDMVpq5ghJdcRlAPWQMojzviEenw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lcYU2HJkRjty/cP430RlYaQhG5UchP8fttJjVESfiipDasefQ9c8xRgBqK7/zBTnTIgbMPER7Qo+NLtrGdkPQpztDyHzirtK6uEw751DFSFsfI61iJkpl7KGfa/OoweGZlR2qMY87ggaXY8dE02wJz4E1ap16sZPpVjU0asPDxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTPhokme; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTPhokme"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC15CC2BCB4;
	Tue,  5 May 2026 14:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777992590;
	bh=inmvLJcpsZfCXoffDMVpq5ghJdcRlAPWQMojzviEenw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NTPhokme0mO9HmEjFFR0aw0/m24fKBtcvUENCpp++EpFgq/BuzFoVU/eRVngrSe9K
	 116HqziMyLKKIQHFVpn6Yk3VI86Cl3uWXBKrdQX0LYl24BDZQjCgvawr/fvf0SIt/z
	 ogMBtDFXRhCxx2jT9w7VnOnWn8iW38Efh/0Vkc9N+mNZuuZnz7kyAA6NsMfpQdnNEL
	 +hPGNTTpeYechXlXmrYUUvjs6BJtryxeLX25XxYvPFQIMNIQP7bEoOlZvDw8vUWAMt
	 pYGJXsra+JMjatqH9lOsySsj8hF0fIr3TW1eB5Xg3W6rFDV0/j4cjsszaIN+rYp6ib
	 k1ToCTdP8PFGw==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: ahci: Move EXPORT_SYMBOL_GPL(ahci_do_softreset)
Date: Tue,  5 May 2026 16:49:07 +0200
Message-ID: <177799234208.1552180.13374705274167411139.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505042310.909857-1-bvanassche@acm.org>
References: <20260505042310.909857-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258; i=cassel@kernel.org; h=from:subject:message-id; bh=inmvLJcpsZfCXoffDMVpq5ghJdcRlAPWQMojzviEenw=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJ/Mae3Hzns+3379M/NlYruS65Z+jheqIyp9r7yzM2TS TjIw0Czo5SFQYyLQVZMkcX3h8v+4m73KccV79jAzGFlAhnCwMUpABOp2cbI0GC7c+K/2RHvS3JW Ji17fJjXwizAWDx0Z5x9uxKvVVjRd0aG0/qMsaXCc5xlIrj3WKw4MKFFsd7aTcpnxeoT7PtcBAt 5AA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

On Tue, 05 May 2026 06:23:10 +0200, Bart Van Assche wrote:
> >From Documentation/process/coding-style.rst:
> 
> ----------------------------------------------------------------------------
> In source files, separate functions with one blank line.  If the function is
> exported, the **EXPORT** macro for it should follow immediately after the
> closing function brace line.
> ----------------------------------------------------------------------------
> 
> [...]


Modified the commit log to avoid the following checkpatch warnings while
applying:

ERROR: Invalid commit separator - some tools may have problems applying this
#8: 
----------------------------------------------------------------------------

WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#8: 
----------------------------------------------------------------------------

ERROR: Invalid commit separator - some tools may have problems applying this
#12: 
----------------------------------------------------------------------------


Applied to libata/linux.git (for-7.2), thanks!

[1/1] ata: ahci: Move EXPORT_SYMBOL_GPL(ahci_do_softreset)
      https://git.kernel.org/libata/linux/c/a3f75e5e

Kind regards,
Niklas
