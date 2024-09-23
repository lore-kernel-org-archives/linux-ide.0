Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E915F199E8F
	for <linux-ide@vger.kernel.org>; Mon, 23 Sep 2024 13:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727098793; cv=none; b=d1CL1ukMg0DJ8gSLaV27qYm45h82CD1qMX11HLgC8OMveKU/PSZ6ZcKmgEIvwoT3BQfE19440DsbAZe0wB35muTcWQU289kYn6qKEqd11Jsg6Y6heElBkgmjfKE24PyPufeoPttkHOes4jo0nDwifdND9SP2HGYv8Mq2II2L9+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727098793; c=relaxed/simple;
	bh=e4j34YhJy9eeiaJq9I9DxvkJovySrACC9rlHVQFVBis=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=St8q3kxj7EHAMpGY3HaChOvY1JjDNi3CZsRzSbf9rhoW+JQL0DcfR1CYz5UKM/O1T+EXLgdziCUwey6NMwBqc5KYYtWH43bfiyHYcINaEwTr9+OiMfC8vgTHf6Y1sUQJ+Q/Dguy7TCeYXqwwTtd6GchCSjZA7LnTtq9Y4A7d8EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOHQeAMX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOHQeAMX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DDDEC4CEC7;
	Mon, 23 Sep 2024 13:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727098792;
	bh=e4j34YhJy9eeiaJq9I9DxvkJovySrACC9rlHVQFVBis=;
	h=From:To:Subject:Date:From;
	b=BOHQeAMX75kd5EaCy3RfAcw2GCs7bdWqJIZqnNWPQ9sOW7bAqdjoLUXj4aUwcT+Gj
	 O7lBuCRv+1hudoSNnNuPUIrjC+z7RYZXTvumGEAvkdYAkAliL/0WZ5CqgQnsdj1o88
	 KxkU8QQs8ZqLUBcUAHbMloN6uwqfwZWq7n1BStNmIZ0YMRpQRUKskmZLmhg8u6j4Pu
	 ulDUWn07MCJnCW0ZgfPL9knj9gcD5ef/tB165axTGS8nVP8dYgAoek9d8IATdW2/3H
	 4rKg91Nx2EmlMDjaAE4kEllkMP3gsc3qxugeLRffiMCzlKdtMoBYaXUNwnLNk312Yx
	 rLG2q4j7HHThw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 0/2] CDL related fixes
Date: Mon, 23 Sep 2024 22:39:47 +0900
Message-ID: <20240923133949.286295-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A couple of fixes for CDL support. The first patch addresses a potential
NULL pointer dereference in ata_msense_control_spgt2() with drives not
supporting CDL. The second patch fixes ata_msense_control() to report
the correct T2A and T2B sub pages when CDL is supported.

Damien Le Moal (2):
  ata: libata-scsi: Fix ata_msense_control_spgt2()
  ata: libata-scsi: Fix ata_msense_control() CDL page reporting

 drivers/ata/libata-scsi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.46.0

