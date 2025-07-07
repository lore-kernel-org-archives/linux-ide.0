Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C28927453
	for <linux-ide@vger.kernel.org>; Mon,  7 Jul 2025 11:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751886102; cv=none; b=AqpuYu5ZQMC2dW62zLyTiwEFAD3hKXH8TFpBFYJPZMNw3MuExv/VVDPuQA3S6SnHnb9VjVYpqSkcBfJb7vnMCrqZfyga6mGVgF8JzBhlbZnavHLUxmORZKMEgSUoq1a7OIEILWCaZk8WK57aSwAZpxIordIEcciEU8hjw8GPymw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751886102; c=relaxed/simple;
	bh=//Nd45Q3tvoCIbFZILnAULnJW3EjynTdw0XpX5CaLKo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=fCyJkKJQMuf7M4ut9fMY4ELkrxJ4kE6Jz/clqsmKSlp++pJTvgjSB8Vl/J6YUz/bVJFqVVp4JUtrdGOgVTdyG46+5DtwuzyNR814wipcm5bBT+POrYax7kFuOUeOxZAdQ69v5T7hWoO6+B+34h32U6qkEFKE6uWAFNR8+XBLprI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+aoBov6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+aoBov6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587C3C4CEE3;
	Mon,  7 Jul 2025 11:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751886101;
	bh=//Nd45Q3tvoCIbFZILnAULnJW3EjynTdw0XpX5CaLKo=;
	h=From:To:Subject:Date:From;
	b=D+aoBov6OZ/06ycOdMl101M5z6ZqgPJb8Cw8mJoV4XCuN9OH01ufagXHHUey/1JiJ
	 xkDmOwRODyNZDYjzO94TQGx6AgQfQTmhvogPR+QjpT2Or68RqpkEc3t/ucMYC2M3vF
	 7bg58WahwxFoa5tVeei5Aoo561NKiK5q5aZJIdAwBcXW4R7ufheZOXuECj7HgEIKxO
	 98i5FXsST+So0JWL8lCuK/3ljrRqkq4LL6j26Z5Wb9vKoRPhVMzhvBQZxSPcONOkse
	 QiGzmrMaBzVzC5n0AXaEQozBsQzXiOuFraIIPPb+IRAHcSxfMQbTt1ZheAzvqxRqnA
	 3dut6bPHWLzxw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 0/3] libata-eh cleanups
Date: Mon,  7 Jul 2025 19:59:28 +0900
Message-ID: <20250707105931.548315-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

3 patches to cleanup libata-eh code and its documentation.
No functional changes are introduced.

Damien Le Moal (3):
  ata: libata-eh: Make ata_eh_followup_srst_needed() return a bool
  ata: libata-eh: Remove ata_do_eh()
  Documentation: driver-api: Update libata error handler information

 Documentation/driver-api/libata.rst | 21 ++++++-----
 drivers/ata/libata-eh.c             | 56 ++++++++++-------------------
 drivers/ata/libata-sff.c            | 10 +-----
 include/linux/libata.h              |  3 --
 4 files changed, 31 insertions(+), 59 deletions(-)

-- 
2.50.0

