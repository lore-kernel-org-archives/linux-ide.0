From: Jon Masters <jcm@jonmasters.org>
Subject: Re: [PATCH] ahci: Add support for Cavium's fifth generation SATA
 controller
Date: Tue, 31 Oct 2017 06:05:15 -0400
Message-ID: <dec0ba95-6149-a432-b29a-2d62dd1c3b83@jonmasters.org>
References: <1507700271-12910-1-git-send-email-mohun106@gmail.com>
 <20171017065851.GA19939@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171017065851.GA19939@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>, Radha Mohan Chintakuntla <mohun106@gmail.com>
Cc: tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
List-Id: linux-ide@vger.kernel.org

On 10/17/2017 02:58 AM, Christoph Hellwig wrote:
> On Tue, Oct 10, 2017 at 10:37:51PM -0700, Radha Mohan Chintakuntla wrote:
>> From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
>>
>> This patch adds support for Cavium's fifth generation SATA controller.
>> It is an on-chip controller and complies with AHCI 1.3.1. As the
>> controller uses 64-bit addresses it cannot use the standard AHCI BAR5
>> and so uses BAR4.
> 
> Looks like it isn't actually AHCI 1.3.1 compliant after all then :)

I've asked various folks to followup with Intel to see if the AHCI
specification can be fixed to handle the case in which a 64-bit ABAR is
required. That should be something they'd be interested in for x86 too.

Jon.
