Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794058660;
	b=X57PV9CWhcgxjb6yS9ItFYmyti6Wh9Vap98a58FhFfGreWh7DLcZljpTR89WWmS6pwDn
	 M481c/gRqLfOkZ9kA9zIk+i9r2c6nqBR3BQzNQ14oGecPl7AqQqPR21zQhzRf4abZVy2P
	 6nLEJc5nMTPBigyIiGV0e09Sf73Yba5LD9CYqMFOMrxs5z41pdmI9KBomdqVfXv5YSjZx
	 fN56MjwInDhJZgtzmckw5sLZh6ooEvsbQr7w374jISGxZPlC2uz58N/vrlevpHZeknnVZ
	 5cOfxL6NIxQsep3wDuaYFW0JgD38fQ4pfBc/aQlbP4co+C+g0vukIVj8H5rXGzCZezg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794058660;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=WGOZFTO/ozWAphYW481JfnwoSF60JjdF3oRN5BXBpkg=;
	b=MoA2m5s6krtgsGZI1QF1wKMA7scCtfEgKxbA8jn22DfVl6zAFzZtxgT9Y8vCkmU9glTM
	 2G0W6SwQrlpktn66e6xcuUfn2EpaVYQ7Fd4EEvrzAa90jfw+R79SpxXnqUT83EyIGdDIu
	 4CZrhNQSAygw2Mc2H+JGdk6xVgE8xJO40q3hO+twPprVHktBqzEgwNwnhN6nQVWDZIzMc
	 Ni34woJre6GThB1gGUH72dDoSCTcu+56lvZxxL5+5uB6wfCsC5mgnmiOKSr8H6RMQSf6d
	 yPjUAxOqu3rW0+DfQNjeKeJvzmx+9m9W+lIojWHkD8MBMgpk06/NvIsDSrq9gT4sxgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RtWBKspQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C103606A326;
	Sat,  7 Nov 2026 13:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RtWBKspQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D201F0089F;
	Sat,  7 Nov 2026 13:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794058659;
	bh=WGOZFTO/ozWAphYW481JfnwoSF60JjdF3oRN5BXBpkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RtWBKspQQ7drbCGcC+uY9AWdatWOlAWYHXFTTXlekpyEV+rq2yarUxXkw5Y540S6R
	 0hPgrcgLZdN9CHk8F5JSDMy9k1nUQ0oSGPz/qKbK0ZyikIntK2BiuOt5LVYQnksh2G
	 cwgfS8hcgzYz4glgjOPxAhWtg+JRymykUdyNu3SNF1LeIo/JEzxAUWfCwC3TQShMfJ
	 7rfYdvZ/PcKsPM9Jg0SDrrvU6jGF3bSC1c6gjMIrLQouHIdC5Mk23lZsSbejrDRjez
	 PsEKrStiDvSa7h2uRy+zAw+wqwSiCXMLeoYwaxk7Wypadv302qXqHsFZHcy+8ktazp
	 /ruOG4EFNecRw==
From: Niklas Cassel <cassel@kernel.org>
To: dlemoal@kernel.org,
	Zhao Gongyi <zhaogongyi@bytedance.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ata: libata-scsi: reject data-in commands with a data-out buffer
Date: Sat,  7 Nov 2026 14:37:31 +0100
Message-ID: <179405862389.952030.5756129776149980701.b4-ty@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104130638.37882-1-zhaogongyi@bytedance.com>
References: <20261104130638.37882-1-zhaogongyi@bytedance.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=890; i=cassel@kernel.org; h=from:subject:message-id; bh=q3UGElKh5EeyiFwK4d5MIyz5UoMlKAjPU+bBPGFgwv8=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLLea87eofExre9CxpE1opM+Jnzt8dFtaVXk2v+Jmf12Z fDNoD07O0pZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCRsGcM//R6OEwuC6zxdX88 6aVJ9i5eKeF3bUe/ZKkwVGjmXRIKKGf4X/Vfo9pY7WaWSODOCMe7bnu81gYkHrPWSKhYY1q+nqm WEQA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

On Wed, 04 Nov 2026 21:06:38 +0800, Zhao Gongyi wrote:
> SG_IO can submit a data-in SCSI command with DMA_TO_DEVICE. The
> scatterlist can then contain pages pinned without write access.
> ata_scsi_rbuf_fill() writes simulated replies to that scatterlist;
> in the reported case, the copy tried to write the shared zero page
> and faulted in the kernel.
> 
> The same mismatch can affect SG_IO commands translated by libata.
> ZBC IN and GET PHYSICAL ELEMENT STATUS completion handlers can modify
> the receive buffer even if the drive aborts the command. For ATAPI,
> the successful INQUIRY completion also rewrites the buffer in
> atapi_fixup_inquiry().
> 
> [...]

Applied to libata/linux.git (for-7.4-fixes), thanks!

[1/1] ata: libata-scsi: reject data-in commands with a data-out buffer
      https://git.kernel.org/libata/linux/c/a4845f07

Kind regards,
Niklas
