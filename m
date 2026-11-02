Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793636013;
	b=KKGygKLc59Dpn7JdZqzuIQWs6yBzr5jRo/Q+f7NvCdgam69NZdOs/7xHiNORJIJVIsUi
	 i2vK1dIVKj6vwfV3kZpb5BoSA09E6JXI6HJ1BUCybMSCoqiinX9l9nC82y0Bprxp+cqdk
	 dsw+oZUcVchnzrNTb8nS9uAYUJaOiUFUOSZwdNdBQI5Ct9yYKWyDCgdH9PnRUBitqimSV
	 rY9bYcjkfFerKnwHKQ8BmLa0WmFnPgCeBV/xSUzM4AA4Px2dqoNeedI/SEZQD8ZiMPYvz
	 9ssk09vju14/RsC2z6yXn9+EtEwqq8SZS3+/KIQmLywf+zkVG2s7C+EL9oheH9doHUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793636013;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=tML1kVcOElBtDXr8RFYC6frpU22PCs0LQ6gNDQnlN6k=;
	b=vBYQ2t2dlyeQy7k2C2nlNS5u+Fu1cYwSqS7RB202vJ6y3Nn2R1AJBwUpLlrXwuzhI/iO
	 mlkGp6xD+4PyuSVGchif945u2m7UudwonVpgfKUs83W/Trx1hNIGRHP4+BKSY6PA/E4Rl
	 sQws03VzrvrqKKYaBNdXYaFuGqizV0o9hWySwc9EOh0BT1uqeUZ+/5eBlDilX+YNnXn94
	 wzN3Ina9qCdnBCNVdgiZWFIkSfP6f1tGfx3K8BlEUPRk3Q0mI1SDK2h58MfzKpEiRdvuJ
	 JM4dNhXnoZjx4l7zsgXlr3OrCrCRagMyxbcXrE520ktkhn0CU1DoTNDslq5vVpCDplA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="P98WBhY/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D9660824CA;
	Mon,  2 Nov 2026 16:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P98WBhY/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26961F00A1A;
	Mon,  2 Nov 2026 16:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793636012;
	bh=tML1kVcOElBtDXr8RFYC6frpU22PCs0LQ6gNDQnlN6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P98WBhY/UfXXarRf7Uu8jEQP9lv5DK2KLHp7gY3TaAT4MeLeujKEHpunaSS6xAa5/
	 0x1ECkjsr2a7BtFkwCrtw9Udyf8iDkCYpBV3TFtkVHfEXh2DOBX94BlPKU/H6Ya186
	 D52soMhM9lnUC+YJjqtLmreRibst1dRtGQFn/XOQ05YbNbswSIELDhTSghEMD3Qfxo
	 NKd3kZkekEjcDFXf5Zkg6Ma97u4lfawalH8u/jONQvFHSsLTJz1JkjrH3wQ/goD5k0
	 jYf8G8MtqsrXdQBhmT3Oiwhn0QHQRnZZi76xn3JHWLqzGsZjn6iRi1fGDUIQWpck+M
	 c5bMbAHgcqD+Q==
From: Niklas Cassel <cassel@kernel.org>
To: dlemoal@kernel.org,
	linux-ide@vger.kernel.org,
	shao.mingyin@zte.com.cn
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: pata_pxa: fix the inverted DMA completion timeout check
Date: Mon,  2 Nov 2026 17:13:22 +0100
Message-ID: <179363577159.1271393.15310421750488395575.b4-ty@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261031222002591vYvH6hQ_JbuZFeV5bccF1@zte.com.cn>
References: <20261031222002591vYvH6hQ_JbuZFeV5bccF1@zte.com.cn>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=842; i=cassel@kernel.org; h=from:subject:message-id; bh=XRWKvVZgwpi0qxlPRZ0KPumt4ZmwKs90jZrMAkH9220=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJebFu8I+LHs1fzjViO/yo3PPH/3cEyfmV56+CJ0pun1 p104pi9rqOUhUGMi0FWTJHF94fL/uJu9ynHFe/YwMxhZQIZwsDFKQATMQtg+F88+ZnfrngB7+9s rJnLjf3qVz56WhSRKWr7Ilg9pGPPS1ZGhqvT1sU7312dZdel2NfhW9n35BffrtsKH6JfNGcl7P8 bwQwA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

On Sat, 31 Oct 2026 22:20:02 +0800, shao.mingyin@zte.com.cn wrote:
> pxa_bmdma_stop() waits for the DMA completion that pxa_ata_dma_irq()
> signals and reports a timeout when the wait fails.  The condition is
> inverted: wait_for_completion_timeout() returns zero on timeout, but the
> driver prints "Timeout waiting for DMA completion!" when the return value
> is non-zero, that is when the DMA actually completed.  A real timeout is
> silent.
> 
> [...]

Since Linus prefers receiving untested AI patches during the merge window:
https://lore.kernel.org/lkml/CAHk-=whOCnAwXz-FMRdQEDJQ+9b2YXh9M=GHgRay0o4cxSmPVg@mail.gmail.com/


Applied to libata/linux.git (for-7.5), thanks!

[1/1] ata: pata_pxa: fix the inverted DMA completion timeout check
      https://git.kernel.org/libata/linux/c/aa99a446

Kind regards,
Niklas
