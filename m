Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36A430D416;
	Mon,  3 Aug 2026 15:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785769443; cv=none; b=C7b8JTagy/f+gt59EfmGqhfZK+iDvYpyqOqhxqKddTO1I+FxO91FT72ZDb7hnjfIEq0GQaLlX0Yf0AMCR10b5T1Fk+E7UTK5mGADUrdwojmqZMRIWD0F5Yd/O8PhICiGJADKF9HTCXVzGSeCb/SKvMsBmD74MggUhuFs4jqPm+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785769443; c=relaxed/simple;
	bh=P13UAEJsNRRy6Sy98EalwJoBjBBrwHcfE7tvLZS+ymM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hcxYvL10r4kibKZXJE0iD2Wq4IconCAz9TXnPqyL3GgJSu0pZ6z7376I7j4bqtJ0vfp8IVFF/gZn9RCkaGJNykmEPGfMV7ybEWGoGslKQlYrxhtsp2eUjdclHnMa/sepHNoPauUole02jpBYUKMfzaesYSqJmV697Dbwl0RIpuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPjUsKcG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPjUsKcG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30207C2BCB9;
	Mon,  3 Aug 2026 15:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785769443;
	bh=P13UAEJsNRRy6Sy98EalwJoBjBBrwHcfE7tvLZS+ymM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=KPjUsKcGdOiPdxOvMf3P1Z26RNi7MlR203bCmW2n0lV5odbsqTJ1BGIaV26d1Qk/o
	 C0fDoulC/hLPwe3TBFETuX5s/dn2R7lRwq3zo1Ne/BCs4YvLi+Brv/UCR1lqMkiBck
	 Cu+WPJm42+f1Yf+mCt8HIiLOOfT4f9GNTAMDvJN+6RkNbOB+IW3Os5o8HLJY60Lz/z
	 4s61aumns+piMYxqVq+1xRPm2r7D7nWQgu+BXNEsNwzKRhTmkj3ula2/DH4xWm/CS+
	 Jnn1jDmZb/K4QDU1ekNXuPL1UTQsPaRLXEXdnfSSuEDEoHXmRZ2tTHpXddolG2SDL3
	 NXjsADUBIiTGQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CDAC55182;
	Mon,  3 Aug 2026 15:04:03 +0000 (UTC)
From: Pawel Zalewski via B4 Relay <devnull+pzalewski.thegoodpenguin.co.uk@kernel.org>
Subject: [PATCH 0/2] ata: use named initializers for acpi_device_id
Date: Mon, 03 Aug 2026 16:03:49 +0100
Message-Id: <20260803-ata-acpi-v1-0-f606afaacad1@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDCwNj3cSSRN3E5IJMXUOLNBMD09QkA+NEIyWg8oKi1LTMCrBR0bG1tQC
 HU4P7WgAAAA==
X-Change-ID: 20260803-ata-acpi-18f405eb03a2
To: Hans de Goede <hansg@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
 Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785769441; l=1978;
 i=pzalewski@thegoodpenguin.co.uk; s=20260803; h=from:subject:message-id;
 bh=P13UAEJsNRRy6Sy98EalwJoBjBBrwHcfE7tvLZS+ymM=;
 b=XHOwcvekGno2Y06cozfqQJQXfb65Ercmf8lVahuyeDoZcK1kQjxkI9tYpesJa24XiVbdvrroF
 psAUpnS9ASGA5ChA1/wQwxnuxvrFEbneKPK2G2GWTRAqMXWZcSjh+/t
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=W3zk1cb/wRnj6pNGbl3/2Zf3GmPA6IBpNHpDPyJ05k8=
X-Endpoint-Received: by B4 Relay for
 pzalewski@thegoodpenguin.co.uk/20260803 with auth_id=913
X-Original-From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Reply-To: pzalewski@thegoodpenguin.co.uk

This series is converting lists that contain the acpi_device_id
struct, which is defined in the include/linux/device-id/acpi.h
to makes use of named initializers (which they do not use currently).
This work is part of the on going effort in the kernel associated
with device-ids [1]

The plan is to convert acpi_device_id::driver_data to have an anonymous
union, similarly to what was introduced for PCI and I2C device ID tables.
The goal is to increase type-safety (as most of the existing casts are gone),
to improve readability and to make use intent a bit more clear:

```
union {
	kernel_ulong_t driver_data;
	const void *driver_data_ptr;
}
```

But for that to work all lists containing the structs need to use named
initializers first. I already have patches that implement this and touching
a lot of kernel subsystmes that use the acpi_device_id struct and that list
keeps on growing. Therefore, I have decided to split the series per every
subsystem into:
- pre-clean-ups that convert the lists to use named initializers (this series)
- actual implementations that make some of the modules use the new driver_data_ptr

That way the task can be fragmented into manageable and independent
chunks of work and makes this effort easier to review.

Tested builds on x86-64 in Yocto using 7.2-rc6

Signed-off-by: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>
---
Pawel Zalewski (The Capable Hub) (2):
      ata: use named initializers for acpi_device_id
      ata: ahci_seattle: drop unused acpi_device_id::driver_data

 drivers/ata/ahci_platform.c | 4 ++--
 drivers/ata/ahci_qoriq.c    | 2 +-
 drivers/ata/ahci_seattle.c  | 4 ++--
 drivers/ata/ahci_xgene.c    | 6 +++---
 4 files changed, 8 insertions(+), 8 deletions(-)
---
base-commit: 9ecfb2f7287a967b418ba69f10d45ead0d360593
change-id: 20260803-ata-acpi-18f405eb03a2

Best regards,
-- 
Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>


