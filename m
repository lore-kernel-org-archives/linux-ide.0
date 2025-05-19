Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57B81C700D
	for <linux-ide@vger.kernel.org>; Mon, 19 May 2025 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747660295; cv=none; b=Q3q+2Npe4dHTlB/O91xw+WdrE93QY/GJO4z3klitXTHMPswzP11S7xQqgEYPK+307UCYf5p6PZBjbIQkVZ2AyHOX23LPdAFHNwUEic88lQZpOZ7IkEYKuVb6YfICJOyiSRf9dxlvnMXz5TpQAUMIQP/ow9TGJYYFKSJI4aKQ4lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747660295; c=relaxed/simple;
	bh=P8RdGThU+hipR/2ad3qsz05rSrV8fdqfpNK+4SlxH9k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KonnMoAHauVexkuhqp0pKT92GHxWBDz3A8QxL2JPUjRar8CiKgYcIOYzfzK98fvpPY0V0qQN4RyDhoN5kDCtiweHpwVF/qp7+ha6AgSVrxLREiEtK6Tt6KrCs/zaBKRWnGfjot/mfDVjabck6gUFmb9svZxMAOMEgwF9GfRqOxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=URXRugDZ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="URXRugDZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747660294; x=1779196294;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=P8RdGThU+hipR/2ad3qsz05rSrV8fdqfpNK+4SlxH9k=;
  b=URXRugDZmzN0kwujEfu43u7ISGYkWCSga+KXK12tKV2wMfaoZiurucso
   nD+Am2OWhW869YcQpuhU5VdSWtDY7uzNWN11Mum8MSEE4ylo+kLpBGxJr
   caQVIiHf0uu5jeHdhJpPZPtQx3+lUfhWLW7+4HQlpjHxwHR3Lxyo6uplh
   F32dJiu4K0ouOyKElqZznST3OzoPDtkeuqVl7ATsWvKvkWo6lXlPbklyy
   /T5KLEsZcaaslz9W/kThbjtcfXzjZGuvRDtwOYG7KVP7TA5Dl4WI06jor
   uDAz8G6p5eKFbQVBQog+8lRbzpssPNVa9Tw8vEMbri475zLtZrDeaSShC
   g==;
X-CSE-ConnectionGUID: RaUUczXtS3OqgHbuON8MuQ==
X-CSE-MsgGUID: xVJsoY+HSNeuXStsKCsatw==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="60900848"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="60900848"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 06:11:33 -0700
X-CSE-ConnectionGUID: 8MjmC/5nS5GOJvSUuHALnA==
X-CSE-MsgGUID: 6LhtoAN+RMOWj4tVd4mDeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="176482580"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.201])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 06:11:31 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 kernel-dev@rsta79.anonaddy.me
Cc: linux-ide@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: ahci + intel iGPU problems
In-Reply-To: <aCdAvkKOfBEQCnZd@ryzen>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <aCdAvkKOfBEQCnZd@ryzen>
Date: Mon, 19 May 2025 16:11:28 +0300
Message-ID: <875xhwvj7j.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 16 May 2025, Niklas Cassel <cassel@kernel.org> wrote:
> I do however see a bunch of i915 timeouts.

The i915 timeouts are normal for when its unable to talk to the display,
perhaps because it isn't there.

BR,
Jani.


-- 
Jani Nikula, Intel
