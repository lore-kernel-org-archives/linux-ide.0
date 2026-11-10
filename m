Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315856;
	b=06uJYfSicxsEEpZmT5CzkXW/YBJyV5fwdKI2KhpAo4Lwb9XpQ/xw/xaiV6J3dWRl3SRl
	 saylOilvRVXxs98w7VO2YClCSyE1L40JsiU3QL5HSSyuwChicwZ2KIJfYPETBmtZV6TXg
	 IOlfd/NhVZdKUX5fFZBcj4o+FDjBckQl+1OP+Jo3VMxBXKdU84Uq1Ca/rqSBK9vFI1mXg
	 rBcCoP99w+eIWcO1zGm8uCyXj+bHDCu0APonlB/Krl5DHxJA1vPwRfi++QffygM4+sq7l
	 uz7FpRu4EAD3Q9qTXBEo3taj+rJooPZLvrCJRDCo/VzJRnui12lzzb+p1+b2+KNIXSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315856;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tRBj0hd4kaimfZ7aiqEkPW10hiJ7O+ngDh9mnytzhEQ=;
	b=1icftgTDsvaNxLOrjaUL6IqqGnE93rowsljnz1YFzlki7IAsqJzjjdB8BPFefrnIEYpi
	 Cb5AUDDLYUL2a+Ycyn6pfI2mhBpXmLkZuwRDaOQGI6zaDGPCYfcuM4eBSDZJ7U8k4D9ao
	 KrfOQCjevsZgiNxlFQRTjRsx19my/WnBvFa2g0F7MZvnsow72CHukgAX6oEhwIb4gWcuf
	 zjc4EeANz6YNZOhXlsRxtVIIZES2SylLJ1RKgVMQA4HruxdC4U6gQ/lyWKgGgaI+Ou+Xr
	 26vSp3CEkwPZjKTZ2ra1XNqfemi357ijKn7XfLgQoDYMLitYVhUVtXnODDfccyUb9WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CFfYATNd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F8B606A74B
	for <linux-ide@vger.kernel.org>; Tue, 10 Nov 2026 13:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CFfYATNd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30331F008A1;
	Tue, 10 Nov 2026 13:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315855;
	bh=tRBj0hd4kaimfZ7aiqEkPW10hiJ7O+ngDh9mnytzhEQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CFfYATNdRtk+5biYneM93wZ6gWu3+LLQ5rb1/MeqdaQr/5qvzSL+YbirwNRfqqXV6
	 mfYaGhYUHFO37lpCJp4j8ks/CCZzKHhALAyEIOSR15/OlX/ty/r7BcUnpquQv+bOdO
	 Iz2mE90gU2Cz4/XlBMPTVBhUPP7zXgQamWzphnOx7CHaaacQou34FifHJmx8z4se+f
	 RXvFMt3RsOZaEB0Ab3en3phG+pcciWk5AuIHhIAOXVh+h4GUiarcsmpnDJ+Fqic2hc
	 6IhauMKvOh1ch2g59D5EZgYWSh24X2EyL0zCFN78jaKGyzVF2O8Rgyc8nwPQc6sO2R
	 PnttIDFRMJO4A==
Message-ID: <sashiko-outbox-207070@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ata: libahci: Do not use an EM slot for the PMP control
 port
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niklas Cassel" <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org
In-Reply-To: <20261110124742.275022-2-cassel@kernel.org>
References: <20261110124742.275022-2-cassel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 13:04:15 +0000
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] ata: libahci: active timer reinitialization across
  suspend/resume in ahci_init_sw_activity() [1]
--

commit 05fb8ee9732c9d4452a8089e2686c99e78769965
Author: Niklas Cassel <cassel@kernel.org>

ata: libahci: Do not use an EM slot for the PMP control port

This commit skips enclosure management software activity updates when
link->pmp is at or above EM_MAX_SLOTS, avoiding an out-of-bounds access on
pp->em_priv[] for the PMP control port.

> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 9e970408916d1..ef760d81d1d1f 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -1033,11 +1033,16 @@ static void ahci_sw_activity(struct ata_link *lin=
k)
>  {
>  	struct ata_port *ap =3D link->ap;
>  	struct ahci_port_priv *pp =3D ap->private_data;
> -	struct ahci_em_priv *emp =3D &pp->em_priv[link->pmp];
> +	struct ahci_em_priv *emp;
> =20
>  	if (!(link->flags & ATA_LFLAG_SW_ACTIVITY))
>  		return;
> =20
> +	/* The PMP control port (SATA_PMP_CTRL_PORT) has no EM slot */
> +	if (link->pmp >=3D EM_MAX_SLOTS)
> +		return;
> +
> +	emp =3D &pp->em_priv[link->pmp];
>  	emp->activity++;
>  	if (!timer_pending(&emp->timer))
>  		mod_timer(&emp->timer, jiffies + msecs_to_jiffies(10));

[Severity: High]
This problem wasn't introduced by this patch, but can emp->timer remain
armed across port suspend and be reinitialized while still queued on
resume [1]?

During port suspend, ata_eh_handle_port_suspend() issues a standby command
through ahci_qc_issue() -> ahci_sw_activity(), arming emp->timer, and
ahci_sw_activity_blink() re-arms it for another 100ms on expiration.
ahci_port_suspend() -> ahci_deinit_port() does not cancel emp->timer.

If ahci_port_resume() -> ahci_start_port() -> ahci_init_sw_activity() runs
while emp->timer is still pending, timer_setup() overwrites the queued
timer's hlist linkage:

drivers/ata/libahci.c:ahci_init_sw_activity() {
	...
	emp->saved_activity =3D emp->activity =3D 0;
	emp->link =3D link;
	timer_setup(&emp->timer, ahci_sw_activity_blink, 0);
	...
}

When that timer later expires, __hlist_del() hits a NULL pointer
dereference.  If the timer instead expires while the port is suspended,
ahci_sw_activity_blink() -> ahci_transmit_led_message() ->
ahci_rpm_get_port() calls pm_runtime_get_sync() from timer softirq context,
sleeping in atomic context and touching a powered-down controller.

[1] https://sashiko.dev/#/bug/linux-b496ab4d-84b4-4d7d-8517-70f1a3e845a2

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110124742.2750=
22-2-cassel@kernel.org?part=3D1
