Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4E138DD3;
	Thu,  2 Jan 2025 19:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735847735; cv=none; b=hBIvoVk3AXPnTB2qqgHmhtP3HW3CysAIB658BwA59uM1C4BpFcxpzY11PLnacTktkizRGFxVcija7C6bCeDYytP6WZ+tToFmrahf3RKoFZSOtxPnDl6cP/JQzk7O4mXdxWrYXlc5sHA6FRks8nxlYVXqe+4SbO9f07Nu0X9T7V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735847735; c=relaxed/simple;
	bh=KcV3QFI2ZE9ECVzD528IkAqVHoxTiKTsGIDJy3xVsvM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Zdiw9qm8g65J7LwKI6DLrro6ISYwzyqaJRfhHN2P+AMfUzJn7PVcl/CjpQ4DW8XohLLyKitaHh6m8ETft1Mii8VqJ6YPhZ3zfizAKWVrDIoPSyNuG8Ztca9j9uQkJOH2A79qQABjQ4i5jCnBGrSAN71zwZsTbQTtA82MbM0dpEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=h6oRgOk6; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="h6oRgOk6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1735847712; x=1736452512; i=frank-w@public-files.de;
	bh=KcV3QFI2ZE9ECVzD528IkAqVHoxTiKTsGIDJy3xVsvM=;
	h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=h6oRgOk6ZNkYDhRNkoG2zeNZ2Lmgz3oWfomuONVuXw22Mr/zQNG+xUv8/spOn38J
	 YSGTcjA1gom7pV0jlZMUyfVmEXUYylwXQuc3jlRWrsy0Au8Qo+w0gqL4Y7OFNs7go
	 9dw64H9s6f+pNAucoxWaH/ekyU1COyTbY21fmqoDccTt6K7+c71eAeMA76CM+Gt1E
	 eOv7D/9B3fICOF7OnMB6PKqnim++vgD9TG9qtdvpANcQcsuyk4jQY4TzWf8r/kmK3
	 VRW/GEz/HRe5J+UYOYqpZ4OCCWiSIeoRRz0q7z6SIUJZ1kxCXJtgoOpr7tK7jNzao
	 b5lXMQ9pp1XD9OZIng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([217.61.146.33]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mq2nA-1tojPG2a4w-00ZFua; Thu, 02
 Jan 2025 20:55:12 +0100
Date: Thu, 02 Jan 2025 20:55:11 +0100
From: Frank Wunderlich <frank-w@public-files.de>
To: Rob Herring <robh@kernel.org>
CC: linux@fw-web.de, dlemoal@kernel.org, cassel@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrew@lunn.ch, gregory.clement@bootlin.com,
 sebastian.hesselbarth@gmail.com, linux@armlinux.org.uk, hdegoede@redhat.com,
 axboe@kernel.dk, linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_Aw=3A_Re=3A_=5BPATCH_v1_1/3=5D_arm64=3A_dts=3A?=
 =?US-ASCII?Q?_marvell=3A_Fix_anyOf_conditional_failed?=
User-Agent: K-9 Mail for Android
Reply-to: frank-w@public-files.de
In-Reply-To: <CAL_Jsq+PEdH1b-aoN2nFJMRz--abXPqZ=sftPnhYKWpj0VjroQ@mail.gmail.com>
References: <20241109094623.37518-1-linux@fw-web.de> <20241109094623.37518-2-linux@fw-web.de> <20241111203611.GB1887580-robh@kernel.org> <trinity-796b046d-1857-413e-bb82-78e700d6b5ac-1733138371404@msvc-mesg-gmx005> <trinity-a84b41b3-79c5-49b5-9786-eb89f85578cc-1735843472332@trinity-msg-rest-gmx-gmx-live-548599f845-gxsb9> <CAL_Jsq+PEdH1b-aoN2nFJMRz--abXPqZ=sftPnhYKWpj0VjroQ@mail.gmail.com>
Message-ID: <F92E6B5E-CB0A-429E-821F-FC87C3C69C29@public-files.de>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WaaUNduwprSo8Rw2SnSLhhl/4G//xG/JBxkJqQG5R9Yowcif2OF
 MkDtmqWs25NQE2Veorx1VPAni9E5ksLAwPtTAE5faFFVb1wBN5PLx2P43TXr0lCs7XFGLfC
 AsynmZgsxuLpHOGZg99SZJO0zTxoiOvXE7qQH7wZ1S9A8BmpeyzaYrwTrvgdRFYU9opIGcZ
 9MXrlSGD+vTfo8FE+ju0g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lig0t4PBHRA=;FoPrt7xYqPzS5KqeMUqAQD+3Dct
 GQsK3oPzFoo2Hq5JM/C9rWIqOR3ye2OxHK74lF7ZFvi8Xdwhz3wQfTqi/6mwJNwPrnMqK9v6q
 IIJTYUhjCOzE3Hs1QJDoZwiTwRskuf1Yzpz4zspl6hRxCavWVwfd5SQzUyT1ZoHuXDSuroUbW
 pqURl3nfNQTy9snvTHAsqg7uA2vu/RMnua33Qfz2xPsBnJS1WwZf3HUe9u1w+N1Qqv6myHMHa
 Ym1yY2GDMhoyAsg+Iy1Q+6J/feZUPHhQ+arnWExSsgwwDRFodnlDM6DXWG3gBQuWTQlALWmvS
 v01LDYZABcXDjmv2iRup8TYjNAm/gHjcvtCwAekUfcmvW8JsRL14HvMJLcTqwnZ+jxt0v6Ukn
 b6ess/UOH34Dyzi54lhKCfxNIF2fzuY7QVUxTkuqwRsoOts6bOqIyNJlb6qX6wbnoJa2HBJxJ
 zM5sAaLIGHqQT18rTsp3Ebc1tQQn4gmpuxfoO9NYhfLQuBBp5ZBM6F2WVfbajfcPvmXmypCLu
 r4Vo4mJb6S65S6t8Gnpp5YwbL9YSrWnxJn5iCd00GaN6jufZEmwY4rGsiq3r7VnDCwHx/oa+J
 Us86+hG0N4AmDZEOluO1V2vdsaBfEIYMzgW2dNI/NbGM7bl4tmGF9h0ZBRG3uBe1dUXeNroPY
 zxeIm7G9ew7SIVr0pyd58QP959Cci0RK/Pc1a8S1ikXYkHB7JJ1B6ftyItRCvxnMYuoeGNiON
 NeBGWr0vp1PIB+31PjZ6KG70RVw4dpcfNBwow79XmU/s3VigblwXk9fD47VViZNwiO+iofxwQ
 PxSEOM8DJTu84UyPpRddsrhAFWbA+sfuVYu3xs5i1MIGpS0lrNkU7x6i5N26ZywzJoP6p5yPv
 HuR1wbW32LjBpdDcfZAzHQ1H3QtcErQZlyQAJgpaVv4dqDh5c986jkiR5Yu1Fdp3N8vHlWztH
 t1iDBvB4WRC5B+P5V9m8z7trJ3mT0WX/f1VJZtBvQ/JLyzpQrJDE+PLDw7Nk3k6tzy+0cyfLN
 zM/Fc1N9GWLjWY5nCK3iay33mAhTl3xUAFzDWfYPnIcCBDLoXhcrsrLlQ22IwQ02yN8++qNFO
 THZfG8FsskEYg7JskHeHRkWqBvxLSv

Am 2=2E Januar 2025 20:46:05 MEZ schrieb Rob Herring <robh@kernel=2Eorg>:
>On Thu, Jan 2, 2025 at 12:44=E2=80=AFPM Frank Wunderlich
><frank-w@public-files=2Ede> wrote:
>>
>> is there any new state here? got no answer for my last 2 Messages
>>
>> https://patchwork=2Ekernel=2Eorg/project/linux-arm-kernel/patch/2024110=
9094623=2E37518-2-linux@fw-web=2Ede/
>>
>> sorry for the html-entities=2E=2E=2Ethey came from my gmx webmailer, it=
 is reported multiple times, but i cannot do more here :(
>
>As a maintainer, when I see any discussion or comments, I drop the
>patch from my queue=2E That may have happened here=2E It is best to resen=
d
>if it's been more than 2 weeks=2E Though Marvell maintainer response
>times are often longer than that sadly=2E
>
>You haven't addressed my comment either=2E The subject needs work=2E If
>you don't like my suggestion, then come up with your own=2E

I have addressed your comment:

>> Here and the subject, "fixing anyOf" isn't very specific and is just an
>> implementation detail of the schema=2E "Add missing required 'phys'
>> property" would be more exact=2E
> imho it does not match what patch does=2E=2E=2Ei do not add required phy=
s=2E=2E=2Ei just disable the nodes and enable them only where phys is set=
=2E

But maybe i can name it better=2E

Maybe something like this:

"Fix binding error caused by incomplete nodes=2E"

>Rob


regards Frank
