Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65B0F516
	for <linux-ide@vger.kernel.org>; Thu, 21 Mar 2024 23:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711063448; cv=none; b=qhkMNAM8NYkcUMYJ98DtBRkhzRhF4ubphLe/iyODPpzpLr+uZRIWlbDLtccwvY+9Gkc1Sm7jHbS1dov05I0KRkPYPXdqyeT3WPNg711bI7aS7oaFmUG19MftZx4v1n92u+23DTvkylf87B16q26+1RSFhmPwMXoMiZ04pW0qSlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711063448; c=relaxed/simple;
	bh=ep/O/yKkNVjDocgkDvj/tX/43GeYcXx38H3L9JOp/qE=;
	h=From:To:Subject:Cc:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MV/v7F45sTPbO4deybyMnfdzMe7uIs0hqLxrIwhanheZQd85gFY3fo+TtDX8jBjLMWJ+oiQ4egY2ZEoW9z4mtrds3QQbSDEMjibuc22BiAIXXmG88SKCAmY4UrkLF46aF2vYMlMuRUwcR9u1/F0FsbY9JaqrRnA5s6IqmY4Rt6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: "Conrad Kostecki" <conikost@gentoo.org>
To: "Niklas Cassel" <cassel@kernel.org>, "Szuying Chen" <chensiying21@gmail.com>
Subject: Re[2]: ASMedia PMP inquiry
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org, Jesse1_Chang@asmedia.com.tw,
 Richard_Hsu@asmedia.com.tw, Chloe_Chen@asmedia.com.tw,
 cryptearth@googlemail.com, temnota.am@gmail.com, hdegoede@redhat.com,
 jnyb.de@gmail.com
Date: Thu, 21 Mar 2024 23:23:59 +0000
Message-Id: <emd6ef2021-5996-41a5-97d9-9864d65bb534@e6a850b0.com>
In-Reply-To: <ZflnYu5W5WnnzDio@ryzen>
References: <20240319091322.10909-1-Chloe_Chen@asmedia.com.tw> <ZflnYu5W5WnnzDio@ryzen>
Reply-To: "Conrad Kostecki" <conikost@gentoo.org>
User-Agent: eM_Client/9.2.2230.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Niklas,

Am 19.03.2024 11:22:26, "Niklas Cassel" <cassel@kernel.org> schrieb:

>However, from what I've understood from how you have decided to implement
>PMP support on your HBAs, I assume that setting the PI register to 0xf
>would also stop Delock 90073 from working with an externally connected
>port multiplier, so that it probably not a good approach after all.

I can see, that you have now reverted the changes / merged my patch with=20
additional description.
Do you see any possibility for overriding saved_port_map as kernel=20
parameter would be possibile for asm devices somehow?
Of course only as opt-in.

Conrad
