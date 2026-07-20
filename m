Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B9E449B24
	for <linux-ide@vger.kernel.org>; Mon, 20 Jul 2026 19:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576842; cv=none; b=AzV5180pzAf0pkusFkqN461QGUiE/Zx34uwPV8Yx9dVneJK8V4mPUAbYQ/RlbC0cRSqJDsyM7tkBrNm28fNLTLzudVirtyRbp+QLagF8IicXjSZfr1FdDQUU6NeQaFlAsRtaHQsptUGUegmkqIrzB4r0b4NPfZAk85KnKBVCdQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576842; c=relaxed/simple;
	bh=IM8OcCd1J5H5NYYxqt8/UURDJnjX3/PpwHj5eTTFHqg=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=BY9j1OfiqiWwlvd7Its5ldZp9G0uQi5qHKcghlbh6IyAl6yVSGPh8Eas84ZuHm/ux8CS0gmmVKgI+6Sy26c20sjriqZrI6kN9/yhGxp7CC74ZeH05wfogzSlGo5tBEfrZ8k5k4teQqYM+HKEuD3Uk3LroYZKGlm9LcnyiXYce9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NFqWtqou; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=O/kNxkKn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NFqWtqou";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="O/kNxkKn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784576839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IM8OcCd1J5H5NYYxqt8/UURDJnjX3/PpwHj5eTTFHqg=;
	b=NFqWtqouhoqZJAk7dfmSrgzGyz1a0J2IzMVyoo6Z3PBQF8GKJ+Pjav86PrcxoMw2SKKNhP
	IqptS8ZgkoTmzCVPNSWECtQUlo5T1HhhokTxfemxnRHx9UyXYlS1uORUsmpF3UFknf8d3i
	Kimuzhk51W0kz1X142VXZZQFbAXuhmU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-tcoVOJ-LOMmPiJiz6-5Onw-1; Mon, 20 Jul 2026 15:47:18 -0400
X-MC-Unique: tcoVOJ-LOMmPiJiz6-5Onw-1
X-Mimecast-MFC-AGG-ID: tcoVOJ-LOMmPiJiz6-5Onw_1784576838
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8f39a46efd9so78085126d6.1
        for <linux-ide@vger.kernel.org>; Mon, 20 Jul 2026 12:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784576838; x=1785181638; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type:date
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IM8OcCd1J5H5NYYxqt8/UURDJnjX3/PpwHj5eTTFHqg=;
        b=O/kNxkKnCD81XB3AuVxQg1Ev+PoT/b7IRyNA8m5nBCT1e6KNH2c35r+cEW62QVwLDx
         pgW0QqC+hzUDnB48DyUP4ILUOkwJIkXs9TajJxHOc91XXvuYCE+0Ej83gfz/yNTCmCna
         A6EGPnqou8qxMzBqLuPrjtxl+6pwuAtbo98LULLFg1sWkJeK81biEpDW4SLQfJ/W8CXv
         aR3F4j+DReQCk5JDYctgw/82scxAWvNoYjOyNMWYdmHyQHepzxcngJWOiFTnkWiA2Zt9
         YA/kQLjZTMPadB96AvvxW/L/HwRjYDpwVdf5+VRjPBGfaLVwLce2axqTH2O/tEj41xtx
         p4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576838; x=1785181638;
        h=mime-version:user-agent:content-transfer-encoding:content-type:date
         :to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IM8OcCd1J5H5NYYxqt8/UURDJnjX3/PpwHj5eTTFHqg=;
        b=qJdPWFV1KDmMkcwS70CTqZr3HQmFTx5pIKwWmzu0G0RAuXpaadd4V/A8d1LIPOSbPQ
         zowVr+hJ8Dv5gcodYSbS2kyn1u3QRnAi3Rn/5RRvtiHKOFxooFGQ9Jz8mfoJYV2wJry4
         QggQfzgNJ9/DtbmDsuirK62AYmK2/LZhygzVf2TyNYOGqauhZh6P1b4EBYfi6HHLdtmv
         bTEzPtwzABAhCOoMFIjndhHpN7ysva/SC6leTXYj1DjC7asykL6TBijwv0+tjVezkCYf
         cl5GqmbXVkM9tCRcMHKCqQixrLPSA1EQFgDv/LC1weu5W07qhiAA/Y5xa6+7p+bD8IrQ
         tGhw==
X-Gm-Message-State: AOJu0YwsemFMAJQTpVUlBDXIrKKgolUEhrMaqWo3WCUr5ggzmbPzL/1a
	1CoxyU7TeeCT0B1OzizjTJxoIOPvTwjVO12DnG9ZSkV0C5wNx/TYaSN8l1B4t20UtyqCjIvJKmU
	mNwKW9t+6RpZxiPfi9QX0fZy+QmCJ8qjL9F5XW+/ThwPlLiUac+1IY8hk/iJCJS0apEc3ob9BKt
	iGRL9NNf2wQp5oymAgm7hWX5aWN9inJ3CKsoguwj61J1uD7Q==
X-Gm-Gg: AfdE7cky+BRxoooQv8C2Nc1H8+u93QECc0l3zRGHD4cQ1SBPOsb9CeepraOTIEePt7d
	VGqGZYunWH4h0hXPMYwrOIT54BdtNMZk/lf7ZzecB5h038XnKjpVfqODskw4v6hk+plzpc3wHFo
	H5WtytG6u7vwLGKJciZ5S1fMGeCKmLZ0ccs7+jKk1Vdh8C7QhaXWuayHzsOg6ZVK7Ld/mnZOR3J
	VIslKiR2bVabPk5YVBlkGQ6hRF3aN0tOunN+sOB+7LfDBBmx2b19y/P14+xlWJyQPDnIFDEfVXq
	0vbvL4fTf91kx2K+MdBUbX0ulUwAjNpg4WdRx+w11zCqTySbr7LKYNqj4dcGFmhWhAVu0OqbC8y
	DfWCdPY6xqLFuZ+85zUse/g9xetDRThJaH8XX
X-Received: by 2002:a05:622a:418b:b0:51c:ca9:7cdf with SMTP id d75a77b69052e-521298a8897mr152412151cf.2.1784576837791;
        Mon, 20 Jul 2026 12:47:17 -0700 (PDT)
X-Received: by 2002:a05:622a:418b:b0:51c:ca9:7cdf with SMTP id d75a77b69052e-521298a8897mr152411741cf.2.1784576837110;
        Mon, 20 Jul 2026 12:47:17 -0700 (PDT)
Received: from loberman-thinkpadp16gen3.rmtusma.csb ([2600:6c65:2440:d8c:dbb1:97f1:a6e6:766b])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5214f504892sm78706291cf.20.2026.07.20.12.47.16
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:47:16 -0700 (PDT)
Message-ID: <1b6f060321c3822e588f93da530688c008e8034e.camel@redhat.com>
Subject: Subscribe
From: Laurence Oberman <loberman@redhat.com>
To: linux-ide@vger.kernel.org
Date: Mon, 20 Jul 2026 15:47:15 -0400
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Subscribe

