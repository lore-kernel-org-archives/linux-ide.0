Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61FC3DA5A8
	for <linux-ide@vger.kernel.org>; Wed,  8 Jul 2026 19:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783539408; cv=none; b=R1f0WzUKP/LOLHH2cVGFfl+XjFdAq5wCqUgfZrH3Bv9dtDZBOcHkG/84nS+1xvgSOXnk+0258ND0qE9HDz+/2hc1ymz7XotdrsUv0Z0iHBN9rhBLGe2if8lkS6Kkod0vbz9fESYEORAUkOKxE2vmcmnRuokzIRK1CRnSsY2uD1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783539408; c=relaxed/simple;
	bh=Bp20pmfmIzmLRvyuwx1yjV7QmXePnir484IJULXYoQ0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=J7XXA9Wg0/nBwdKz5QUXzgvmVfYjfrKMfllLft42h14BLun54KbNcHaslEu6nptziY4l88zn4/LqF2WOktmLr20t1CCV4Lk8nmk9vsGlk2y8m05TCWNv0ahqZNH+pMyMId8Xmy3saG7z+zlnCy0fXU6kDtQHx0llf0itEwj70B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LeeurlSA; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LeeurlSA"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2cceabd70f5so22748095ad.1
        for <linux-ide@vger.kernel.org>; Wed, 08 Jul 2026 12:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783539406; x=1784144206; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bp20pmfmIzmLRvyuwx1yjV7QmXePnir484IJULXYoQ0=;
        b=LeeurlSAjZhIwpCbOpeZBnUQ3JBLe60ZAPL6ecboZNL9wajaG7Hb5TacvlW+Uv0C99
         muDAjVzrHxnHxR4pli9JR9bh8LwkNEXcb1EgvwG6Ca6DL06Czwb2pDHQtROAOpLvcGMU
         OfIZ4p2Pzfy83+3J/5vDAkwFVRdlXZV8hoFEBJ4nq8REYu+xKJE/64i0jz/W3RXM36Sa
         uuDrybXm9aszySGhopurbu8D+T2klSqfghvMzmUP8sIJcjykEiscYft44IzmGlla6DhM
         C8Xmd0c48H6QlgSNeNQvyL+/6lhwp65EdfhxNTHy3NyV1ipkfM/JdAiimfKU0wfK3dTY
         QfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783539406; x=1784144206;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bp20pmfmIzmLRvyuwx1yjV7QmXePnir484IJULXYoQ0=;
        b=NlWzaFTij2g85uC4f9IAD2WXF0BRlf3bRo1GiSPRzMwSnsZxMF/MGkGYW96FPDwnjB
         WmjE2E7MqHNuIfMDHgt4RcuY2IJ6Afl35xpGrnxLyQt4g715WhllqxFTDgOBhyTe/Wpw
         dkcGXQrxEeu3cfQBRoTCqW4OiE94MFabZ23b/bmI7/qHQx/I9WoEjTG07G4DgVs+TtDN
         qguH1JxF+078zblRP3j+xXhCwjJnP1CCM+4dfy1KgpTNznEdT0IBOU3/mJOSdiOKMDP7
         mtztSr1gXd1RGHnVfE2Q3qYcsbT2FLmJbAUlYI+7lU3MQn6dM5KONU7F2M8d4+T9vkLt
         R24g==
X-Gm-Message-State: AOJu0Yxm65xH9NYInzcaW9Qr3cHRKj1sxtgUiuV2pIkHi/GPtKdc9bbf
	0ARZlwotB+ivQ0OqrDuriENIHRpujHNm783fUs+Hm+GOe4yIiv5rMgEbeMNLZ8xSClFwb7E4It+
	T64g8CjZmiSMkzA==
X-Received: from plbv22.prod.google.com ([2002:a17:903:44d6:b0:2ca:cb8d:7da7])
 (user=ipylypiv job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:903:b0:2cc:fd6c:c5ae with SMTP id d9443c01a7336-2ccfd6cc8aamr10463185ad.38.1783539406045;
 Wed, 08 Jul 2026 12:36:46 -0700 (PDT)
Date: Wed,  8 Jul 2026 12:36:44 -0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708193644.671852-1-ipylypiv@google.com>
Subject: SCSI EH wakeup deadlock from deferred_qc
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Damien,

I've stumbled upon an issue where SCSI EH didn't run upon command timeout
but ran ~10 or so seconds later. It seems like a recent regression from
the introduction of deffered_qc.

When an active command times out while a non-NCQ command is waiting in
deferred_qc, SCSI EH fails to wake up. Recovery stalls until the deferred
command's own timer expires.

When an NCQ command times out, scsi_timeout() calls scsi_eh_scmd_add(),
incrementing shost->host_failed (1). However, when scsi_eh_wakeup() checks
whether to wake the EH thread, scsi_host_busy(shost) counts 2 active
commands (1 timed-out + 1 in deferred_qc).

Because busy (2) != host_failed (1), scsi_eh_wakeup() refuses to wake
the EH thread, deadlocking error recovery until the deferred command
times out on its own.

Thanks,
Igor
