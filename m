Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793615532;
	b=FDKjmiUbmqcz4zYajRzIKc1MxbWZcbIguDF0rCTx3f3PGrzfyQfYeWy2ls87L1TcZL8H
	 u50wx5jVJcULD8m5E7zgZOiKHzNuGe17AGX9HgZmTgjq7SbAw+sXqwG7GLccsFHAOhxpJ
	 TaQLrgwN4+6QiofVh3+6qBAlvYnLYdeHFgpjzI6mYrPl9lfQtFyGIetx0IqJXLoGDUK1r
	 slWrKiXtgZpaCs1AIg9dCGNuXctR008DmyBkvJSnK6VnPSLqo8TNnqBkZStbotjExyqoJ
	 dn9BV2zteMcfQMorWusOmc1JrEgsTRA41pN7petGWrWbIes05Cq+Bb4y3NI+f9sVk5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793615532;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=Wtai/DfDw2aoAmXkl5MQTcGdJ4P+UgM5hUwjFW7j4KE=;
	b=zK0eSeQOJYiZWopz/Tbq3YdkAxyTVx/eh284qq0lNrj/OObpry03ojs1VSyQsKLkzZJf
	 h9HCVclPE6iUQLN1wiIGtnHarclFhbU4DHG9Jy+C2WHC5q8LwVp05lAurACNsTCWVtmbZ
	 wRN87dNssCoacjrMR925X60hYGCdtRi4OX0z2MNXhrTKuYN+wj4jpuIuWW0PFA0VOkHT8
	 gQs40/GUi7zIr+CNMyDcWaRna3qvV01tsugAjCNZ4sOCllnSx0IMcwUrfq3i1T8/i3xTh
	 Fk9NuiEV/OsyWzr9SPLGuYmqcqjca7nMJgCGoR/rz93vxY3/3wwoRaUX1dm2MzYpGsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D1R6yX3s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3E9606A326
	for <linux-ide@vger.kernel.org>; Mon,  2 Nov 2026 10:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D1R6yX3s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3F41F000C1;
	Mon,  2 Nov 2026 10:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793615531;
	bh=Wtai/DfDw2aoAmXkl5MQTcGdJ4P+UgM5hUwjFW7j4KE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D1R6yX3s4qSPkEM5LZSEgm5uXilLkrh6IOwwLEJk3VNAEAzw62zw2cc40bzBDlZiF
	 ZRLXXUAb1c5C1BQuDTvxV2jzmBgPXhHDI+/w/I84yqPB94+W/4/D5LqePuwYqIc9xx
	 m6vR8ZrEdmMjy4WHXgBcFGrIXkrz1IKi/nzqW2mBzt5TGlM2kqj6izQBST41raxJ1Z
	 H201mAhahVJe/aTwGL21FVUNOLgJHyYGVKRT1vylWzUNlgD+zUC9AvDEMedvb65Aw3
	 Pg8tEgIRLuo9uq1Ermv8qXcGRFE6LT2rIuoyxtio+WERA7+xuL4SXYoQ0rVTf0YCY+
	 b3wZhcPuwztsA==
From: Niklas Cassel <cassel@kernel.org>
To: dlemoal@kernel.org,
	szczepan.durawa@intel.com,
	szymon.durawa@linux.intel.com,
	Roman Gardzinski <romanx.gardzinski@linux.intel.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH v2] ATA: ahci: Add Intel PCH-S RAID device ID
Date: Mon,  2 Nov 2026 11:32:02 +0100
Message-ID: <179361541612.1163257.14203626205064050345.b4-ty@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029140004.6991-1-romanx.gardzinski@linux.intel.com>
References: <20261029140004.6991-1-romanx.gardzinski@linux.intel.com>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=674; i=cassel@kernel.org; h=from:subject:message-id; bh=iELlfI85iEdgY+9kqROLTTHS77JtsiEYpNOorAXAEJ4=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJepC2K6NjGb+Bwg1V7VQZ7Q/rTvbVFXe/ez9fiFrW4v bkhpHRfRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACZyJYWR4bhPill9ytonBXcW nq3YfiNZZcdhppdMlQaK995eaegUl2H4n77/m9enommVYurflstOCs0rC+I2dDMtud6zW0tq0fQ D7AA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

On Thu, 29 Oct 2026 15:00:03 +0100, Roman Gardzinski wrote:
> When the Intel Nova Lake SATA controller is configured in RAID mode (rather
> than AHCI), the generic entry in ahci_pci_tbl which matches any device with
> the PCI class code for AHCI, is not sufficient, since the SATA controller
> in RAID mode uses a different PCI class code.
> 
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Niklas Cassel <cassel@kernel.org>
> 
> [...]


Changed the prefix from 'ATA:' to 'ata:'


Applied to libata/linux.git (for-7.5), thanks!

[1/1] ata: ahci: Add Intel PCH-S RAID device ID
      https://git.kernel.org/libata/linux/c/c49a14fa

Kind regards,
Niklas
