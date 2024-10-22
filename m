Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2BEC2C8
	for <linux-ide@vger.kernel.org>; Tue, 22 Oct 2024 02:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729565140; cv=none; b=Ai20BKgEVPNXnfA7CenwF/rV4Ln5vTGeE69ow2vrKmCNC5vL/tfxgPRvJbRMCoyslIGwGDsz5Co79yGsEsZmxZ9wXMn2ziYYGMTC83I9Zl/ZbOgOHE4DkwYAW9dysELIVnHIWDgQJcCrJiF1rG0KbcV8JD2gQ3MRxzkncdThDb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729565140; c=relaxed/simple;
	bh=F2zdvhmGCqFa0ysShZJzAt9UNZAHCxPaOw8nllgu95I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mSEzZBkG+GVvzOql3VezLjFQlTojoyh3pVGvJRrf08U0ka/5pYTkfhx4QDBovEHBq1I0MCLqerl+9H6z3C/TRfXjN/gloBGiVNMQXF5NksjYD2EBQJnhDAiKrmBoxXMEiq3koV6p3lvB6RQT/DfwT0fdZP4CHT8Q6JRZU+Te6qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LY1TWT4n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LY1TWT4n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C35C4CECD;
	Tue, 22 Oct 2024 02:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729565139;
	bh=F2zdvhmGCqFa0ysShZJzAt9UNZAHCxPaOw8nllgu95I=;
	h=From:To:Subject:Date:From;
	b=LY1TWT4nk99JqHCXRoBB2TS+xObPndSnzJ7i0OsjCX5VV28/HhtF/QGHLktC5KB73
	 71fZYo8EcIX9JojOUcE9W/5OZmIgyTGfM6SzDJLHDWCH2IEu0khpTRSBxsKifI/vNq
	 CiiNVGDpdxhP9tAgInyHNp2eodzZeu6Dlc9HhhfylZTfdR22dodxYqkwUpf1ZhC612
	 QiP8TC7Zc3bqvxve27x30P1zGStnqmbGFVyk6vg50V3Q2ejgAAj9NKky4CCS0cj6Hq
	 Qxfu5KFfOjblIQOrJQg8RVPFmE0J2NwNH0M97YkDSBZ3hzFRpViSvWEbfFOhHS9w4J
	 I6JpQghO2dvZQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 0/6] Cleanup and improve libata-scsi command emulation
Date: Tue, 22 Oct 2024 11:45:31 +0900
Message-ID: <20241022024537.251905-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first 5 patches of this series refactor and cleanup the libata-scsi
code handling command emulation. There are no functional changes
introduced by these patches.

The last patch of the series (patch 6) improves the command emulation
by accurately handling the scsi command residual and transferring back
to the requester only the relevant data of a command reply.

Damien Le Moal (6):
  ata: libata-scsi: Refactor ata_scsi_simulate()
  ata: libata-scsi: Refactor ata_scsiop_read_cap()
  ata: libata-scsi: Refactor ata_scsiop_maint_in()
  ata: libata-scsi: Document all VPD page inquiry actors
  ata: libata-scsi: Remove struct ata_scsi_args
  ata: libata-scsi: Return residual for emulated SCSI commands

 drivers/ata/libata-scsi.c | 503 +++++++++++++++++++++++---------------
 1 file changed, 305 insertions(+), 198 deletions(-)

-- 
2.47.0

