Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B6E284662
	for <linux-ide@vger.kernel.org>; Fri,  8 May 2026 19:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778268779; cv=none; b=FRAaG9/A0auBOk1apoRY+DL5CnukdGQh4OhaOHnD/Xz3U3vljpedjEd5TKzFg1h2XkLXZLzv+HFNQnRI29nfgA+FssxMJLLLqt3hM8vFc4o75EaKYiH8KPrjNlrDXfEdC2qdvSDfIuFgiXQNyzaJEkvZ4FesQxPuh66q24BQwRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778268779; c=relaxed/simple;
	bh=ChDGXEmlBWdk7aNqrsHjo2rw2rZmfJDfEqJv/ZCe0vo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VQfPI3TzYx/Mf/JtXbxNfia9/DLtJH8riP4f08S4wLxbZk8oWTOU6XEDodZ8uzbxqqjUFael5mMdG/5XBHo9QA5ZKFWRW1ABL2f/e1H0KontL2fUiASvY434W2nWtJx70TKMniqLhK2BHyMRNXYLoZvQ4yiVjW3aVPDxpN7L7Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwFynRPq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwFynRPq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF875C2BCB0;
	Fri,  8 May 2026 19:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778268779;
	bh=ChDGXEmlBWdk7aNqrsHjo2rw2rZmfJDfEqJv/ZCe0vo=;
	h=From:To:Cc:Subject:Date:From;
	b=KwFynRPqool5Q3CQBvUqZiXbPM5lDqFVYoZT2Z4G39WaMrofoeKeiOfL/oMgeQs++
	 Xril4AjsgZgZxoRZMe5R7/7zKFQt0fE8fC+iia54dAhsBVRQh5ZUEQ0qjhZwlsK7zN
	 WPkhgq09R5uK3aX8bajN4awAzsH3rGhDPDZnscfrNeEesgF+3RtnkgW1UFzAayANhD
	 bwKPVXsJiiVrM4p5LX8d3rZ2q/52Hxgf5yClB2UEovWhKIZ59fN7bn5pxjDOvIPTh7
	 9T4VuftRtjBAC6G9QZhvxIXqJDtLLkyMANu8DPQxPM9Bsan+Ia4tKsmwBVxr0c7FBc
	 7zotWAU3s+fSw==
From: Niklas Cassel <cassel@kernel.org>
To: Tommy Kelly <linux@tkel.ly>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	John Garry <john.g.garry@oracle.com>
Cc: linux-ide@vger.kernel.org
Subject: [PATCH v2 0/2] ata: fix deferred QC handling for port multipliers
Date: Fri,  8 May 2026 21:32:40 +0200
Message-ID: <20260508193240.176735-4-cassel@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1572; i=cassel@kernel.org; h=from:subject; bh=ChDGXEmlBWdk7aNqrsHjo2rw2rZmfJDfEqJv/ZCe0vo=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDL/WUX0TVJ4831ihseucLWv+oczl36RrNpd9XpdZ+7Un xONz9Ze7yhlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBE8mYx/E/fpV5Qvux52PPn fzPar37+6SAnxjd3Ykak2fv9J51uCMxi+Gd85lqFZH74Hc3tcQeKTA/I+LfNspq86JFwU1/AWcm oVi4A
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello all,

Tommy Kelly reported a regression with PMP that use CBS:
https://lore.kernel.org/linux-ide/ce09cc21-a8e9-4845-b205-35411e22fba9@tkel.ly/

It turns out that the ap->excl_link logic used for PMP that use CBS is
incompatible with the deferred qc issuing via a workqueue.
This is fixed in patch 1/2.

While looking at the code, it turns out that the deferred qc issuing via
workqueue is misdesigned. It assumed that we can't mix NCQ and non-NCQ
commands on the same port. The limitation is that you can not mix NCQ and
non-NCQ commands on the same drive. However, with a PMP with FBS, you can
issue (mixed NCQ and non-NCQ commands) to the different drives. Thus, move
the saved deferred QC from struct ata_port to struct ata_link. This is
fixed in patch 2/2.


Changes since v1:
-As pointed out by Sashiko:
 https://sashiko.dev/#/patchset/20260501125410.1204490-5-cassel%40kernel.org?part=2
 My patch in v1 unintentionally changed the fairness of
 sata_pmp_qc_defer_cmd_switch().
-Add a code comment which explains how the ap->excl_link handling works.


Niklas Cassel (2):
  ata: libata-scsi: do not use the deferred QC feature on PMPs with CBS
  ata: libata-scsi: do not needlessly defer commands when using PMP with
    FBS

 drivers/ata/libata-core.c | 16 ++++---
 drivers/ata/libata-eh.c   |  8 ++--
 drivers/ata/libata-pmp.c  | 29 ++++++++++--
 drivers/ata/libata-scsi.c | 95 ++++++++++++++++++++++++---------------
 include/linux/libata.h    |  8 ++--
 5 files changed, 104 insertions(+), 52 deletions(-)

-- 
2.54.0

