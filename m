Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A89C488DAC
	for <linux-ide@vger.kernel.org>; Wed, 29 Jul 2026 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785331174; cv=none; b=Xb2TaoFfDjxWF7+YJ5ZaEODqgHKQ7D1IPlCEq73CQuy+bz6IK5AxoVAPFmrLz0oYTJ2x7iVtaNx2onPkBCVTyJ+O6B5fUjnePHSUwFu/7TZMRpS+/feU2Xq0KDDlTkjxWjfmm6KML2AWOomysLsxMgtzDAqGIdwcZLYFXtL15wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785331174; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=gC5pT6jsCU+6G8rh1QTLRpHyGyd9iyD3dcpd3R1moszbQiQiSddPskbcJ3MxjCbY5z9MO+58VTpC8BHXg3ig9a71KoCBrwJZn80SUljKBtaqrhGjBspqDxTEUv/QTThTjPfX+/nY+nok+dO5dnqSaiI1pKzt53Zh/R2H5OD8Bj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TgIdg/Wn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=H9X1gDR3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TgIdg/Wn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="H9X1gDR3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785331171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=TgIdg/Wn5Veq25lAJQwwQ9M/I1//XlVIFt1mFh/1yya/b5ydDQAPMC9BZA/p7tOCCV/KnH
	lbhwyXBTG1QWPh3XSgBgqcNfNhxfrVR21IA9pg9tRaqX6zyL71nro8kLqzCpcQYl0QgiMM
	schdMyQGFeiWojKupBc5mGZpov4HHW4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-m-InF7K4M4q5ugHeI5IfJg-1; Wed, 29 Jul 2026 09:19:30 -0400
X-MC-Unique: m-InF7K4M4q5ugHeI5IfJg-1
X-Mimecast-MFC-AGG-ID: m-InF7K4M4q5ugHeI5IfJg_1785331169
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c12e43b98so10291951cf.1
        for <linux-ide@vger.kernel.org>; Wed, 29 Jul 2026 06:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785331169; x=1785935969; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type:date
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=H9X1gDR30kHIiJYTXnDIulovMpqNGB0UTogPsEQZ+szLjqnKFVyKKYYLHFGUkC0j8V
         4HXUP2sZPqoS0r0fuDPbAjF/+C/iMNZt/PStYgciITEbWWQ3eFIM49w2rIDe1EkLwGep
         rv5xYQYzwhsfHPCexQJKR2flBWCFy3TSl9sggou5Lq65gJCWPhVEvvA3mZIBSjJo80x2
         ogtcNgK0bVyv+8dstT6X7IUp9V9ZB7Zp9cLkI5R4LiRso1lNzyokfbQfOdkiylFfo7VR
         nc2pXj/xhCxdf8PHNGQdLyihO+cQFJ8KtbjVqDQszcTmqOk6lYyPNdLcfBvUm/YRuxQN
         Rlyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785331169; x=1785935969;
        h=mime-version:user-agent:content-transfer-encoding:content-type:date
         :to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=PeTX/S/UQOhhUmcU469ojfkxSpTSqzJ30N2LU2PiWJYifxuE4zw0KfWCJVwkBQHMoj
         cceGqBAek61lXVOQqbAftFSES58ogsSmNHspyBNPL1DHq6Hx0LdIQkK+FT/7ZwVgnCHG
         OPGB+rlBTZD8QZu+prLQ8cQRp7tzOzLz1xDYKlJC7BzDeg/qK+aLKl9kO951lM0L3jG0
         oCLSuFqHjUtvoVwEXCRE3+bbO31XePpx+wUQctjElT+biJ/4AMFCi3ziDUuDGl1jVn2R
         d+g6zvZh2gHf7DFhKpCLwYRTEtksBRLlV4OhFgUD401+r4b73g4OcZOWwelZtXXdZWkl
         ZesQ==
X-Gm-Message-State: AOJu0YxqSrZVPNeHQpa5TLkt4JI7wlPziqjGQoI8E0bCg4EzBL5IRT0M
	STGEAubx+jSIU+3tS4dV5sEQlt202asxsvfl9h0iD95qHFYyjgvJYK20FuSmz2WUkM5P3fRO3ti
	hfX0PwO87TPI25/JZ/QJ/VZ8YSGelftrgSaJPV1mZ6Fk/AM0laXvXPlDKi1+AMewex5pNUQMvQ+
	4IcxstEmu/qgdK/1jBtvlKgEnWyJ+2wF1C65eJC6Bq0NraQw==
X-Gm-Gg: AR+sD10tPVMAaZvTk+PYpdGadwdh3mw1jvP+wtVwvq9J2Z0dU0AVmZp4x3okl+fQAzF
	vrw/tFhhRwp5rMDnVG1z/BPdBcbh8HUf9yZgTfmI71lFtij2GGwQgefE9ZrjV+rK5iBzualVTww
	ZHPOFs49rqj9wnJcIvpGFD1PMmj2tIZrVlz4O1/2wfBpBCdnHRFZZ/FRgWedBopTalxSU+ATWnB
	9PfSs5B/g4vBkTJnlQQljPsMYSclsm7l31S9s9rxNUqGVds3vsIkCNvhw3efMraUe1j7qlOuTlU
	XfX2YsB5KGlvxecOz32oGzshZxNpSk3g0xtWYlSmjJN9YEknuO/B4zpl3zqCXKAZ4qeGVGBRuiF
	PUp7BAlJuDEApjgs+JSZF/ToLU3CvuaQ6WqKd
X-Received: by 2002:a05:622a:2b4f:b0:528:5c1:f223 with SMTP id d75a77b69052e-529d7190261mr57954421cf.77.1785331169609;
        Wed, 29 Jul 2026 06:19:29 -0700 (PDT)
X-Received: by 2002:a05:622a:2b4f:b0:528:5c1:f223 with SMTP id d75a77b69052e-529d7190261mr57953991cf.77.1785331169041;
        Wed, 29 Jul 2026 06:19:29 -0700 (PDT)
Received: from loberman-thinkpadp16gen3.rmtusma.csb ([2600:6c65:2440:d8c:dbb1:97f1:a6e6:766b])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529e2b4f241sm18595531cf.7.2026.07.29.06.19.27
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 06:19:28 -0700 (PDT)
Message-ID: <6d75008a5817de9bc89aaadb0eca485669678d95.camel@redhat.com>
Subject: subscribe
From: Laurence Oberman <loberman@redhat.com>
To: linux-ide@vger.kernel.org
Date: Wed, 29 Jul 2026 09:19:27 -0400
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


