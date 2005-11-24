From: Edward Falk <efalk@google.com>
Subject: Re: [RFC 2/5] ata_acpi: libata.h fields
Date: Wed, 23 Nov 2005 16:38:22 -0800
Message-ID: <43850B7E.5010506@google.com>
References: <20051123154055.6ab5cab2.randy_d_dunlap@linux.intel.com> <20051123155103.7e58140c.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.12]:31704 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932607AbVKXAoD
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Nov 2005 19:44:03 -0500
In-Reply-To: <20051123155103.7e58140c.randy_d_dunlap@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Cc: jgarzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Why do this in the libata layer rather than the block or device layers?
