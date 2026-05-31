Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AAD3242BE
	for <linux-ide@vger.kernel.org>; Sun, 31 May 2026 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780233560; cv=none; b=X3TWjlY8vwZs14Q7SKGHTFZ4nGYoIFmMvUO4ZKB2O8FUZyHfW0DuP09Q9t6MP44N/Hrs5Vb77GMTSYFnSQezUmwkc9u3GAYlzlSlKPiixXaP6EyfoLT0l7lTGiYJA3uDFNCqu6rOZbPq1cvv2seQADJKV93ddi2A/CUQErW4chk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780233560; c=relaxed/simple;
	bh=5gMTxKI7kazwmO/AGvg3AsTHwkTJ/mJUo/UvfeDJLfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RFt9jkGfRB/4KPvtt7oyvOX806aSa0G0zFn/eOTxPyl06jRB7lnJzX0017ghlvs4JaRdj0qoDdYiN44oqYbZJavcEy8yWKlWlTcSAP9Avs//TvoGsSt5tsP5aehFRLxuRgfQCXJevagbC79sNxrw8Q73ahGqztG9+xPu6fKTB2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FP5Q86sG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FP5Q86sG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836261F00893;
	Sun, 31 May 2026 13:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780233559;
	bh=CKyt2hZ/OO+fr3O+ijnTMA1frXhGEEAhqX4lxXzrmYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FP5Q86sG+iR3Y3qa1hTR5S8T9FYETFz7NcFuIMqJD3lStveHwYdLiZHiJW43dxPwB
	 m6RteRPKXTptgIzd7metIkKmECGDJQHsAhdZ7kbLmbAJ1KMMjqAB5fk1wJUGkN5A1d
	 yWf867fF1Evq329Z6fD1xil0RuzCrLbUYwV+L3h6vz81JejyH0NFAu2D2ABKM0xwig
	 Kqva5/uAtHf4QB/SU9JocmTngUxsa39St46YK5UCRKwbJeEd01hyFRCbsuOSVPTUmQ
	 iaym25g9Zpx5J2VHcVm/bWB76uUKdcVeGks5J4Vbl8AZOXCwPJ1EGV7REprc8RavR1
	 2o/rxlRbls50g==
From: Niklas Cassel <cassel@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.com>,
	Marco Elver <elver@google.com>,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH v5 0/2] ata: libata: Enable context analysis
Date: Sun, 31 May 2026 15:18:56 +0200
Message-ID: <178023346284.910004.10011918287082760985.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1780077008.git.bvanassche@acm.org>
References: <cover.1780077008.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=537; i=cassel@kernel.org; h=from:subject:message-id; bh=5gMTxKI7kazwmO/AGvg3AsTHwkTJ/mJUo/UvfeDJLfU=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJkTL28/866kiv47Kyu+pTKqO/3NPn3v1TRjUq68Mb6X PpF178xHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZiIjQ/DP6O6skWKx+LZ20OV qmdymZbZu//dEjI9teUT04ulP/lONzAybJDz+Ol3KvhW6P1VUgcez3Ozb3es3bHLQVrho3j7jal MDAA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

On Fri, 29 May 2026 11:03:08 -0700, Bart Van Assche wrote:
> This patch series enables context analysis for the ATA subsystem. Please
> consider this patch series for the next merge window.
> 
> Thanks,
> 
> Bart.
> 
> [...]

Applied to libata/linux.git (for-7.2), thanks!

[1/2] ata: libata: Add an argument to ata_eh_reset()
      https://git.kernel.org/libata/linux/c/ef174c36
[2/2] ata: libata: Document when host->eh_mutex should be held
      https://git.kernel.org/libata/linux/c/e6e1e1da

Kind regards,
Niklas
