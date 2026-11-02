Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793618176;
	b=FCUJXzUEHrdQX1EZAkmIETi+szyW4+Sre41LqZ3fRozChld6rjBZZEtOQYU4CByXAnr+
	 E8JeJZAfs+yykIXduAfiTDSicQa/TDxaWNl/GodlJEH+noZDzKYrZNuahuKmSgiWUUtmf
	 5zsZUXHQpsuXldZqFi42RMBkX8OBcarmZFfDSqDPPdVIR3+Ifi2yucWTVe7K4ppyXDLaf
	 k8Dcsq9ZnZLGHuj1THnJP8O/wVgwPf/xn7oEhkXYJCG7BDKKWRrh6X4ki6S28FH2d+4Yw
	 sH8A94yoenUrDpnciTK1GStomyripblI8x6D5zP8Pg3VsLE9PZcDXe8A74nY0797gww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618176;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=G4cSiLwicJVmHrLeMpkn4zK8J0hU1kTujxDyRkZxuMY=;
	b=Dfq7G2lwWwFzuDxadKqlmaMLBZXqyZIaE4bFoXPaEQXHjlDBlANjpCIlRiQ5iThbZkor
	 wofHcjlKZ7tJ+GBrK8M+QAZMkkkP1TTlMf5W6jEjsnqHEWg98vIwIB8ox95MJqrV8H1Mk
	 FSFqumEdGyERKnB3ea3AR/SKcndpWUkOdnDgVhhIUG7R07wu/F0Lvsna16lRVqi/Bzk9l
	 4e+Q6tK3QCB9nSAcjja7+7RI+euEuMLO4pb8rjywO/fCAVYxylErNEE+EWf0M+c6+wVH1
	 abvYJUiR/qDuYvcdzWMl+qARFTxBOY4KiAB1dwr49HPKirCh2WOgYuWUNUlrgQIDhww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=0x0f.com;
	spf=pass smtp.mailfrom=0x0f.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EEE606A33D
	for <linux-ide@vger.kernel.org>; Mon,  2 Nov 2026 11:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9EEE606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1438d9363fbso2169347c88.0
        for <linux-ide@vger.kernel.org>; Mon, 02 Nov 2026 03:16:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793618174; cv=none;
        d=google.com; s=arc-20260327;
        b=QKV//+schk5d4L3NOwDqdMajPidEUlTalV1n+fFNBhRD8geZwEXeM8Ld8DJTsspFC6
         xdf/qy1Jdib49wTDcacUt7aW+y3dlE9upoo8eZNcfQSWuN35Xh38Q9SlPo3csCh2u7hF
         ewYb16kSPqG0wCjXEzqqBc0HWO9LGJlepv3ZteBC9kMH7TNcyXI3g5+vhz2gk1KICi94
         Z98LHg0Zn2qt/N9PdIUWYwgJdVh9YZAknpVzgC/a5IqJPXSrNogz0mItv0q/xafUdbDj
         D5eyCgpZc7kJ7AqNzgIRHvxSXbDe5w2+aVu/cN+2axFPePlwembS0IbVuM8D8VCtiq3M
         JUqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=G4cSiLwicJVmHrLeMpkn4zK8J0hU1kTujxDyRkZxuMY=;
        fh=3DgqrWcJN6CnGT3uHMpoVNB7/Z30GwueI0TG9DAGEys=;
        b=ikrUac/SYFfibun/8O1xPIvbjmoXpyZWOcThFEWiFMycAjyE9CbX9fmKDB0ikzZdUC
         tcObcYQ71dinMbe7U0DDUWMcbXgy4QLbG5oc7wJ5Sfokjo470xcSo4REZUtUorPTBlud
         rbgIsgrbW83QtF59p0iBWs6z5V9FLOAvLw+X4NaYid9VzKxbr1IXwLn42/9QiRKhMkeR
         bR3/KeBQWqLmdLUmxGFORGI9Xt2FEnxLwtczQfVvKDf6kgsnE6ClTF5VX8jDshJjqxoQ
         WzsVk76FHF1gl3ikvKgL+inXLhm54EvtLtgeg6quWrmpcEwK0/2A3LAJLyqRd3jQ+iw3
         4ncA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1793618174; x=1794222974; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G4cSiLwicJVmHrLeMpkn4zK8J0hU1kTujxDyRkZxuMY=;
        b=LOFmaa+Am17SrsOWZACAb0ay2UBOgyLboNMlmS0WrslonGmwLB6mmGf9+a9F2uYRBp
         t1oGQX4TvYHqqr539NBgu/vWo/t38y7cm2LX28LUKYux0HkRPhHmlHFKvNZZaxP5LbJ/
         aXg3cwGfZ729b9kOu7II14xn/TeXMYRP0udag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793618174; x=1794222974;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=G4cSiLwicJVmHrLeMpkn4zK8J0hU1kTujxDyRkZxuMY=;
        b=v/MfJQ2CXPPMTwV2x0skX7ADFFVDzMVTz/fBzRTOshywU5sl3wG1ZSzAPaUlFw1esQ
         7fcwJ7aIeY3TuGmselB/2QUhAO7COXBV/nfIb0kWJVPiLCYF7y36wZ5gdg6um+XE/95/
         Qw7EjMi/xPdFl5GQk2ypQT7j+lWAdTbEX9G/8k9dgtCrpzrtFpiAYOgVTkvyGkm/G3M2
         nH1tCw3PhsPHTBfzfUlapHXvP2r6OneMkq2jEOgQePTZqAio2wH6qiW6YcTgPxM8Taw6
         bywkzvGsXNgQ10PJiqko7oimJjKq7voPMrBU0evuntBfQOCSdx5JhYQgHkKS7xC+00pb
         1Ekw==
X-Forwarded-Encrypted: i=1; AKwUvBznIREHS52vZAJR/iWTdlbFmjXDFgsbOXFSuwfHe5teUMKTnNTl+vLnn5tjb+gDOrYuOe05YENFlJI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKKsGZA9xsfMOni+06rzZhSJYAp5ZPBejKXuz7ApbA4Xk8xPJRU
	QJroJrcrBwNYCRNJTclv9rN+coBCQutqMMBXl4djBRDjEE3Gz56FBS75GkkDkyVZgDrwXxSe6PR
	3z0RLCcDHpzrHJ1CWumvlz5WpbfagVdv0rqP/Carjng==
X-Gm-Gg: AYBFou295BNj8qVPY0Y5UWHKwsYWHwwM1S3E+nbMvmq7kB2MiCUyuR/ka0qVZpU9KyN
	wDLwr7/+lR2oaAI4ZMZKXQbg6Rlu0OAE6tzh6YkfnIgBBLYWCrhfg4/gIgOqXweodyoIGDb84X/
	LQmOSBICahbYG+TcPIdyAO12cMDhax+Ohoohrm6vLMFdbX3ydRQiclTRYHBFWtpDKxbp+VZFW2v
	8XmzdwfGoCq0/JTjcwEtxvAaAoqciQduT+9+AAMP2PTLKCec21Wz2TtK1BOqGI94nnZaFgHN8T9
	5g/yo5bj8YSwueJ0RifPnXeXsfHehLzddHVGvSW0opaIuoCmPMAAcX1yDBFee6pyOakQXJsweL+
	b4jctTgT9AVFWgjMwRwlKwqgOBwjyxZd8tl3h7sg=
X-Received: by 2002:a05:7022:b903:b0:17a:a3d4:8b17 with SMTP id
 a92af1059eb24-1ac5ac4f0aemr12405133c88.12.1793618173694; Mon, 02 Nov 2026
 03:16:13 -0800 (PST)
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025034410.808796-1-daniel@0x0f.com> <20261025034410.808796-2-daniel@0x0f.com>
 <auhrgteGO3TwU3HD@ryzen>
In-Reply-To: <auhrgteGO3TwU3HD@ryzen>
From: Daniel Palmer <daniel@0x0f.com>
Date: Mon, 2 Nov 2026 20:16:00 +0900
X-Gm-Features: AclHuK_yExg3ifaj_wGpLVEITnJd8FTrPLgBisUUJnC1vT5nQFSQxKqD4ZAFeAM
Message-ID: <CAFr9PXmU3noRcZ=nvm0UsU74gMvNcneXdksOGJ-AGsZ8xaVMog@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ata: pata_artop: read the ATP865 mode register
 through pci_iomap
To: Niklas Cassel <cassel@kernel.org>
Cc: ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	dlemoal@kernel.org, linux-sh@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Florian Fuchs <fuchsfl@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Niklas,

On Mon, 2 Nov 2026 at 19:52, Niklas Cassel <cassel@kernel.org> wrote:
> Since your cover letter says that this fixes a regression,
> I think we should add a Fixes-tag.

From what I can tell it's had the inb() from the start and at some
point that inb() started crashing sh and maybe other places.

Maybe:
Fixes: 669a5db411d8 ("[libata] Add a bunch of PATA drivers.")

But this is all the way back in 2.6. I would hope anyone using this
with an LTS kernel would have noticed by now :).

Cheers,

Daniel
