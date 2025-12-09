Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C502236EB
	for <linux-ide@vger.kernel.org>; Tue,  9 Dec 2025 04:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765254363; cv=none; b=Ws1JTZIbebkqv722g51OPgc6eziFkCYI/o1j/Rla1fMUwe9j2NggIgHf2KDDvZYiDwnVcANyOEW2kLLBbQCdfp6UIuc32My+xDU2xb0byjKk0bo8GFFXQeLDBBcZ88tut6QG1rdsnbVkOXWhj1v4LfB8L+YApgiUXIdc5c8aBFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765254363; c=relaxed/simple;
	bh=C9gtQ4TD2Qs1l0em4RrA1j6e0DDtBCpDRsEe9gYYDkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHm0PmsGuQwJT8qz/Z7j97B+bEIMAq4zJ2SI9Ry4F+UJuYBuNywAlDbIGGvGNHXJQO3Z4BibHMt/vtZuAGiP6k9Wrntq30AvetDwyRnCWifwros1ixjJEGnN69HKqNWI0jme1tCD5u5GGOZr5m2/0cOC0/pbixze0j0RsuLbeRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/S1MkRK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/S1MkRK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070B2C4CEF5;
	Tue,  9 Dec 2025 04:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765254362;
	bh=C9gtQ4TD2Qs1l0em4RrA1j6e0DDtBCpDRsEe9gYYDkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A/S1MkRKkqI005PRvRgo7EutGVG+LrAHultvclp3rzF+Ak8URMhKgaFw7pvGbY2+H
	 Po+ERGEDtiW9d9pCIBw6R2+Shh/ZsDuqc/TkNDcKca/Kn9bCIhDI/CmTeg5YZepFn5
	 0ZKUsuuMQVN6h4uJNwyAfTcJyQGpObKBhmPgNc7Wjyvv+WH66b418khzEt7DBG8Iht
	 c7JAlKibT38FD8bi5nfWZ5+RsGzUqNGlF55+ETYgW2Z4CVGAQa+S4QQiBH47+f/WP7
	 BqgG56tApBxVd2clmjXanB6JyxXOGEWihy294cTj5iC8xhvIIMXn7HOfW6kd8Bg2xE
	 q5xe+doUux3yg==
Date: Tue, 9 Dec 2025 05:25:59 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Emerson Pinter <e@pinter.dev>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-core: Disable LPM on ST2000DM008-2FR102
Message-ID: <aTek18SVTkTmKhCf@ryzen>
References: <20251209042359.1467124-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209042359.1467124-2-cassel@kernel.org>

On Tue, Dec 09, 2025 at 05:24:00AM +0100, Niklas Cassel wrote:
> According to a user report, the ST2000DM008-2FR102 has problems with LPM.
> 
> Reported-by: Emerson Pinter <e@pinter.dev>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220693
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---

Emerson,

could you please try to see if this patch solves your problem?

(Remove the libata.force from the kernel command line.)


Kind regards,
Niklas
