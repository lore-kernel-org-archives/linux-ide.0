Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794281233;
	b=R78zj456Q47eojTsJB6Pnacn4UjW+jYYQIXiEWy0qrtg0XxoPxDjOtng3UmurQsB4TLk
	 1362JynUu4FMDAU4P2/sCGrFlakhthThTaiJvGgKVjGFCtfsDjU9XS9DfntIE4tIcCyJw
	 n88Q0jsN7rL+ZFJM8MIRyvIrFZLo5Mps0gYIMQ//sWXV9VZqBGeQUM4cLXdFqqqY5E7x3
	 lvvYUYqaBiCjNPKyT+BBep4CagM/2r+sY6Y7/Yf6JaPBtljaM1l0sjSm7GJFe0Wtdt77d
	 Y+HoXxOeGhvF9TsgyZJlWlbjE56xAjWwCdt1BO5QSw2DYdTjgat50mzuVuSjg76W4KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794281233;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=eawXPhK/eFBjtNe/1dhvjiN3YjyzwNQYK82Vhcgxmlk=;
	b=zO1eg27oNwGZyodpDxUUrHiv2x5oHT1h6oPwWWv1bifcjde6hj9WOODPBeLFWPdfye2J
	 AfiWCcIHXgvd0AlGO2VTTpqYHqNAdH29/N7ieAyL7BNr4JkCRRhCDheRUPFoIaLsITR1Z
	 LjL7jb2jR3/rdgnPeUdSjGVDE2nI2hp/he2O7shwz7QCE3SMx0685UY3IPXw4KRu+nyww
	 ciVuVV01BZJFE+AIg/tJoZJTTcKZSf+xyK87FHtQVLY6KeDO2YJBgXKH2v794cuxU0nvL
	 G+cQiH83SmJpFgYY2RrxSpaOTcdI38JKy4dNBMYBoNRPLtFKwaIbj7bF7nREAMTLttQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=N0EjzIiS;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534C4606A332
	for <linux-ide@vger.kernel.org>; Tue, 10 Nov 2026 03:27:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 534C4606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=N0EjzIiS
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jNsXF6SCPz8Xrrh;
	Tue, 10 Nov 2026 11:27:09 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794281229;
	bh=gT98MkiGoiBsoc873Q+qJViCbrAze7Un+ECFq6d66kQ=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=N0EjzIiSrl/WN+1TX+py10fOT9Y5X9XObFvccG289kXzXD8cN00HQ2NWaYvHJWI+B
	 eNYwoowBldEHRkQvT8YY72x+Wi48ObFSmu8itpyN+QrZcxCAtZj6s9XKrLCx6Alq/t
	 fOgW66EN5JVQdFuoWmDmXYflszSz3xW8ix8oqeSyJfJrXElcFmuqlWLu7OJBcJy4kY
	 UfknhtYxXdo4xRx8jK0XIRV4zlZ7I/Jx7Sa8sPGecfLeoHexlm7iTigt+2L77iod53
	 RZIbORz7iAcIEwiJPaEX0nLIEA/49q7xBXb1JzWTj9QHNpcPPBQKRYIO//Wm8+LJ5c
	 GKGwRzANgn1Ng==
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 6AA3R27I018370;
	Tue, 10 Nov 2026 11:27:02 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 10 Nov 2026 11:27:03 +0800 (CST)
X-Zmail-TransId: 2afc6af28f07637-d10a7
X-Mailer: Zmail v1.0
Message-ID: <20261110112703284t5yS94EoCghFvLKCn4-SB@zte.com.cn>
In-Reply-To: <avI7-lrzsRL_Gz75@ryzen>
References: 20261104220832716LXKf7OaS9dt1VJ8Q959AG@zte.com.cn,avI7-lrzsRL_Gz75@ryzen
Date: Tue, 10 Nov 2026 11:27:03 +0800 (CST)
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <cassel@kernel.org>
Cc: <dlemoal@kernel.org>, <linux-ide@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAwLzNdIGF0YTogbGliYXRhLXNjc2k6IGZpeCBBVEEgUEFTUy1USFJPVUdIKDMyKSBoYW5kbGluZw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6AA3R27I018370
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Tue, 10 Nov 2026 11:27:10 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF28F0D.001/4jNsXF6SCPz8Xrrh

On Mon, Nov 09, 2026 at 10:32:42PM +0100, Niklas Cassel wrote:
> I looked at the SAT specs, and the comments appears to be valid:

They are, thanks for checking.  All three need action.

> Does the ATA PASS-THROUGH (32) CDB have a MULTIPLE_COUNT field at all?
> ...
> so bits 7:5 of byte 10 are reserved, not a count.

Right, and the commit message was wrong.  With those bits zero,
multi_count is always 1, so the warning it describes is still emitted.

v2 drops the MULTIPLE_COUNT handling for the 32-byte CDB instead of
moving the offset: the sanity check and the comparison are skipped for
VARIABLE_LENGTH_CMD.  Field pointer changes remain only for fields that
are actually validated.

> The index line of this patch records 927e75b7498d ... applying the
> posted diff results in 20ba572c0e37 ... That would also explain the
> interleaved - and + lines above, which git does not produce.

Confirmed, and sorry.  Those hunks were hand-added to the emails after
the patches were generated.  v2 comes from git format-patch on the
tested tree, and the test notes now include the field pointer.

> This isn't a bug, but this hunk changes the field pointer ... Would
> this fit better in the first patch ...
>
> Should the remaining field pointers ... also take cdb_offset into
> account? ... PROTOCOL is in byte 10, FEATURES (7:0) in byte 21 and
> COMMAND in byte 25.

Yes.  It moves into 1/4.  v2 is four patches: reworked 32-byte passthru
(no MULTIPLE_COUNT, PROTOCOL field pointer), the unchanged service
action patch, SAT sense data without the extra hunk, and a new patch for
the remaining field pointers (PROTOCOL/count, FEATURES, COMMAND) mapped
per CDB format.  The cover letter will say what is really left.

Kind regards,
Shao Mingyin
