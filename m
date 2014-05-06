From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] libata-sff: remove dead code
Date: Tue, 06 May 2014 22:26:56 +0100
Message-ID: <1399411616.2458.45.camel@acox1-desk.ger.corp.intel.com>
References: <1399204229.8729.15.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1399204229.8729.15.camel@x220>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sun, 2014-05-04 at 13:50 +0200, Paul Bolle wrote:
> Ever since v2.6.19 the code contains a check for CONFIG_NO_ATA_LEGACY.
> But that macro has never been defined. Apparently no one ran into
> problems on platforms that do not support compatibility mode.

It was needed for some of the FRV devices I belive. Please check with
David Howells if it's still relevant (even if its not used in the
default configs)

Alan
