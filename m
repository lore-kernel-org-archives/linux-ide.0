Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ADCF4F0
	for <linux-ide@vger.kernel.org>; Sat,  6 Jan 2024 19:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id F0C8F15213F; Sat,  6 Jan 2024 14:49:44 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: Sergei Shtylyov <sergei.shtylyov@gmail.com>, Damien Le Moal
 <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH 3/4] libata: avoid waking disk for several commands
In-Reply-To: <518e7f55-4a15-6caa-fcba-db6e5a846b6e@gmail.com>
References: <87y1d5kxcc.fsf@vps.thesusis.net>
 <20240104223940.339290-1-phill@thesusis.net>
 <20240104223940.339290-3-phill@thesusis.net>
 <13374917-5c23-1cb4-8484-479cc7d20e7b@gmail.com>
 <877cknu4t0.fsf@vps.thesusis.net>
 <518e7f55-4a15-6caa-fcba-db6e5a846b6e@gmail.com>
Date: Sat, 06 Jan 2024 14:49:44 -0500
Message-ID: <87edeuz1gn.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sergei Shtylyov <sergei.shtylyov@gmail.com> writes:

>    It was a start of my (single-word) sentence. I didn't mean you
> should capitalize it, it just had a typo. :-)

Got it.  Applying changes now.

