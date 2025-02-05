Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A85525A647
	for <linux-ide@vger.kernel.org>; Wed,  5 Feb 2025 08:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738744683; cv=none; b=YiGoj1cNz61Iks5QkBRDLdWkx48i5pphuTmXK+C+eJwP/Uj4ejr/RQ0fpuYQizvHdqTN7i3N4/qjO0YjjThMv1nMf8QfiGfcxWKNlWX8jFrvZHMqPzZkmhBuAlCGVitWeJUazhMW4rW8iINt5eg1hRJ/w/fAQhFST5JuwoloaAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738744683; c=relaxed/simple;
	bh=hCGuwW355QD53Uc4QowtwNlkSZ5A/3EH3Ao7KvYKCrs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=r0oqucjD5ydEMUBGGhmQKK/k4jH4v3t3aiOzN85KDZh0GoooPXrbLJXU8c3AnbU+NDmNx3MbJvpjp36ClnjvxavPPNAJXdT3U5nPh0iavGP9YxzXoUd6Dzl+sd5zQsAZxJDnbri9KBkhAY9Toe2qV9IsPYuTKg+ieRNsvDaGBTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3WfTwap; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3WfTwap"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5901C4CED1;
	Wed,  5 Feb 2025 08:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738744682;
	bh=hCGuwW355QD53Uc4QowtwNlkSZ5A/3EH3Ao7KvYKCrs=;
	h=Date:From:To:Cc:Subject:From;
	b=E3WfTwapppVe9Ekob6F5r2UtcUJKXa187NqXkvTbQUQ6t2HOm9dOCK2z8A4pkZgZH
	 MQxg5BFhv0VbvzHhtjoKAeKs8S3OvRau7gxwEusREKa3Jk3rmqkztcgv2vLRcooJAV
	 0FW2yXyH7/Y+JSE+V1egH5B8yzN+1AWfiwS9IrNhKUkgBBlCMzvHS4owTft5fp7Sx1
	 dAluUd3SATAw3CNdrO/NYY93Dujz3z2n67DkJuFAu5FjZcjXOIDihyWO5Qf38qRQUL
	 w9WfyGtrdaofH4iDOa/PwB9HODLWChQEY5o9t02NVPg5nio9U1aLgjfqhOQ3q0n8tn
	 2vNJkJiwU1kwQ==
Date: Wed, 5 Feb 2025 09:37:59 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Dieter Mummenschanz <dmummenschanz@web.de>,
	Daniel Baumann <daniel@debian.org>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Subject: Samsung SSD 870 QVO LPM issues
Message-ID: <Z6MjZ1Nniwn_uldf@ryzen>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Daniel, Dieter,

Dieter recently submitted an issue on bugzilla that v6.14-rc1
breaks entering lower power packages states:
https://bugzilla.kernel.org/show_bug.cgi?id=219747

Most likely, the problem is caused by Daniel's recent commit:
cc77e2ce187d ("ata: libata-core: Add ATA_QUIRK_NOLPM for Samsung SSD 870
QVO drives")

Dieter is using 'Samsung SSD 870 QVO 8TB', rev 'SVQ02B6Q'.

No longer being able to enter lower package states, suggests that
LPM was previously working for Dieter's Samsung SSD 870 QVO drives.

Daniel claimed that enabling LPM for his Samsung SSD 870 QVO drive,
caused them to stop working.


Could it be that you guys are running different firmware versions on
your Samsung SSD 870 QVO drives, and that Samsung has managed to fix
their LPM issues in more recent firmware updates?

It seems like Dieter is using firmware 'SVQ02B6Q'
which also seems to be the latest when looking at:
https://semiconductor.samsung.com/consumer-storage/support/tools/

Daniel, could you please tell us which firmware version you are using?

We might have to adjust the QUIRK to only apply for the firmware version
that you are using.

It could also be interesting to see if you could update the firmware on
your drive, and revert the quirk, and see if LPM is working for you with
the latest firmware version.


Kind regards,
Niklas
