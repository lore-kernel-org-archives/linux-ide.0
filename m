Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DE3207A27;
	Mon,  2 Dec 2024 11:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138393; cv=none; b=igy/DOVjTkHxBqkHe7RQjznuhdH8ngXQpJIg5AERmfNfhsdWsx0hFLMCsPoLzXpnWUR1cHlv7J1fk9NH6LPyK3ufap+pkBov0hmwZhT5XjkT7zAGN7Ni2b74MkAT3MyFbxVhgrDNzmxu/MBT2EXNo3AZDdO4BV7bOE/pQByzk3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138393; c=relaxed/simple;
	bh=Uc2zRevH+Kbf5f8VX30G7BEfhLIb4tv53u+IgAXh0HE=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:
	 In-Reply-To:References:Date; b=AWdB0J0tiFegmTZ23FGYQFsNESXDJDEbx+u2oFnITcmwguuRLRJu6B1+NGIr8I91PNCwNFdrRnoGo902r02GhMg14sNJb1/TIDroOosdlJBUbirXYnsAhgSMf4kirtjN1p5pjzs7P97GUMAhKzdrfPkOLTc8UdvedlSI4z0xmoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=Wec/KeoX; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="Wec/KeoX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1733138371; x=1733743171; i=frank-w@public-files.de;
	bh=Uc2zRevH+Kbf5f8VX30G7BEfhLIb4tv53u+IgAXh0HE=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:In-Reply-To:References:Date:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Wec/KeoXhkciOJBV6eBagwb9ZRB8LrAUfI5G/Pg0WgjGiwciB/OiLRGJySznAJ23
	 9s+esQ/3WuJ1S6XDMqetDB9SkdNbEQ5LDiFNgUbc2HMG+leP5KOWTMCg+Gu3zL//w
	 BehYLhgyYfWN+Sr19qD1iwYH1D68XGVuukOFXtUcpZ20og2pY4tFFo+e9C3QI3Kcl
	 +BNMrYsiaNSR5t7fZ5YBpgGaXwk4Z22x8tt4z6Sd4N+vF6vk/KLoWKpHA+koOJTxX
	 LQ65YipH2ebnjI8h522oAl+clyGRCstdqpDM10lQpRTEaQkZGPcFKmfFdygXtnDCn
	 al8nwjkJXfTaNVTi8Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.149.104] ([217.61.149.104]) by msvc-mesg-gmx005 (via
 HTTP); Mon, 2 Dec 2024 12:19:31 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-796b046d-1857-413e-bb82-78e700d6b5ac-1733138371404@msvc-mesg-gmx005>
From: Frank Wunderlich <frank-w@public-files.de>
To: robh@kernel.org, linux@fw-web.de
Cc: dlemoal@kernel.org, cassel@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrew@lunn.ch, gregory.clement@bootlin.com,
 sebastian.hesselbarth@gmail.com, linux@armlinux.org.uk,
 hdegoede@redhat.com, axboe@kernel.dk, linux-ide@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Aw: Re: [PATCH v1 1/3] arm64: dts: marvell: Fix anyOf conditional
 failed
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20241111203611.GB1887580-robh@kernel.org>
Importance: normal
References: <20241109094623.37518-1-linux@fw-web.de>
 <20241109094623.37518-2-linux@fw-web.de>
 <20241111203611.GB1887580-robh@kernel.org>
Sensitivity: Normal
Date: Mon, 2 Dec 2024 12:19:31 +0100
X-Priority: 3
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:WmbuKwIPUaMaoZ+9pCvV9RhiMoPE8aSF6dGD7Y3Nc/IQ/9StBY9DKphILNMLZlJqknJ9E
 22lbCPY5SsDehMLGZNaTmqa/nNFgGyTW0cKhlE0F1fRPE4GRukXuZsv14PbI4M4fW79O7ZeWfCJz
 tTbCH2I+WuMTY1eD+lrVwb7pAj32hbJr+UkN2be1L4nNJa0NZY9VZXCo8yZeGp19+t765eQQNbF0
 K1SQuxf1K4c8x/zgRx96LBFQiVUW7S9KpTINmN0VJfuRnEaoTskk2hZMQklgiVrZRmMZ8zKxXMPM
 ko=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:m9D9NzYozQs=;85UGk8rqymSyuI3OwojybuLO3GM
 UzBsf5kQqXGnWY+/ZM75mW9LXJe5ChShlEBkEXQsFwAntHp27dd9bKrIlWhbLptifFX2f4xoW
 qAPKogLJiykB3Vjqyrd6OeORAwsK/X4sdHB5unZHYzSnqpEpFi1S1Y1z8aN+GjEcVNr4LVSVV
 t5wXNEGbNyIYMHfXodIANnQGJl3EF/s5n+9wPxQ8dHOJCfEUryCDYAcfQoYkGgmkO1SI9rDXL
 hUhS4ob9LdfrGw5FLbxSZtUd867HIxyzzzjn6fyO0osxQNs4iV+5+luJWMyJ4OSke0+4PsHS2
 6rdVzB7n/YLGumzcc+k1vTz+scIQhHHmExn0TXYl7mhPgOlP4QlKkUgmrK7S+HQesWQ8u3SzN
 /oZ2YcKqVmZp5mFg24ibj1YX36vuhbH/Pgi7aJ7jmfaW1UInmBpF7LEJ+UOkydWeBxfH9lpqM
 7xuRRvl0VQynUWz2qpa2ty1r3Z3d7BhOpFSPBNYwz/A0iYv+yyzJvtItW7uwk61OPTyu6ibL9
 w4YulsxGea4tbIA9090GQwzq9FOQ5fQSiYwMTCp2sK+U0yi8Y9IArhl2BYbuvLGQy41bgQYwQ
 foS/VpaVXSMi2kFF7OJigs9huyBjSvcmj0l8Win71FfRAEazzdyxxl6R+fQwfSyvyIF6JJWEe
 1Et7eIiFcSMyvI3hE+YDzMu3orgMYKz2S5ETjf9FLsY00pxECZlcggTioBL25EIA2DGZbgkmn
 QkkZh5Cfo8Ax/GC0arE3y5fIWNe9N2sRxPqwH97q2S73GOTua+SN1FKXVrz3cHRTvhIVZMILe
 92ZrENpAxtCW7RKeIV/Mxl0KVSC/ziBDhZo1Hf0qt0MB6WzySA9fJzLDs+5EUi0sRQ5ylEYNk
 WbeyohRrlcALr+IdHlP7adqAIKQ7Z2zJNQqA=

Hi,

just a gentle ping to have it finally merged

regards Frank
